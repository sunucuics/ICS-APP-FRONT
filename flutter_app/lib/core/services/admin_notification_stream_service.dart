import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../utils/logger.dart' as logger;

/// SSE Event types
enum SSEEventType {
  connected,
  notification,
  notificationUpdated,
  unreadCount,
  heartbeat,
  error,
}

/// SSE Event model
class SSEEvent {
  final SSEEventType type;
  final Map<String, dynamic>? data;
  final String? rawData;

  SSEEvent({
    required this.type,
    this.data,
    this.rawData,
  });

  factory SSEEvent.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ?? '';
    SSEEventType type;
    
    switch (typeStr) {
      case 'connected':
        type = SSEEventType.connected;
        break;
      case 'notification':
        type = SSEEventType.notification;
        break;
      case 'notification_updated':
        type = SSEEventType.notificationUpdated;
        break;
      case 'unread_count':
        type = SSEEventType.unreadCount;
        break;
      case 'heartbeat':
        type = SSEEventType.heartbeat;
        break;
      case 'error':
        type = SSEEventType.error;
        break;
      default:
        type = SSEEventType.error;
    }

    return SSEEvent(
      type: type,
      data: json['data'] as Map<String, dynamic>?,
      rawData: jsonEncode(json),
    );
  }
}

/// Service for managing Server-Sent Events (SSE) stream for admin notifications
class AdminNotificationStreamService {
  final ApiClient _apiClient = ApiClient.instance;
  StreamSubscription<List<int>>? _subscription;
  final _eventController = StreamController<SSEEvent>.broadcast();
  bool _isConnected = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  String _buffer = ''; // Buffer for incomplete SSE messages
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 3);
  static const Duration _maxReconnectDelay = Duration(seconds: 30);

  /// Stream of SSE events
  Stream<SSEEvent> get eventStream => _eventController.stream;

  /// Whether the service is currently connected
  bool get isConnected => _isConnected;

  /// Start the SSE stream
  Future<void> start() async {
    if (_isConnected) {
      logger.AppLogger.warning('SSE stream already connected');
      return;
    }

    try {
      await _connect();
    } catch (e) {
      logger.AppLogger.error('Failed to start SSE stream', e);
      _scheduleReconnect();
    }
  }

  /// Connect to SSE endpoint
  Future<void> _connect() async {
    try {
      final dio = _apiClient.dio;
      final url = '${ApiEndpoints.baseUrl}${ApiEndpoints.adminPanelNotificationsStream}';

      logger.AppLogger.info('Connecting to SSE stream: $url');

      // Cancel any existing subscription
      await _subscription?.cancel();

      // Create SSE request
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
          },
        ),
      );

      if (response.statusCode == 200) {
        _isConnected = true;
        _reconnectAttempts = 0;
        logger.AppLogger.info('SSE stream connected');

        // Listen to the stream
        // Dio returns ResponseBody for stream responses
        final responseBody = response.data;
        if (responseBody is ResponseBody) {
          // ResponseBody.stream is a Stream<List<int>>
          _subscription = responseBody.stream.listen(
            (chunk) {
              _processChunk(chunk);
            },
            onError: (error) {
              logger.AppLogger.error('SSE stream error', error);
              _handleDisconnection();
            },
            onDone: () {
              logger.AppLogger.warning('SSE stream closed');
              _handleDisconnection();
            },
            cancelOnError: false,
          );
        } else {
          throw Exception('Invalid response type for SSE stream: ${responseBody.runtimeType}');
        }
      } else {
        throw Exception('Failed to connect: ${response.statusCode}');
      }
    } catch (e) {
      logger.AppLogger.error('SSE connection error', e);
      _isConnected = false;
      rethrow;
    }
  }

  /// Process incoming chunk from SSE stream
  void _processChunk(List<int> chunk) {
    try {
      final text = utf8.decode(chunk);
      _buffer += text;

      // Process complete events (ending with \n\n)
      while (_buffer.contains('\n\n')) {
        final eventEnd = _buffer.indexOf('\n\n');
        final eventText = _buffer.substring(0, eventEnd);
        _buffer = _buffer.substring(eventEnd + 2);

        _processSSEEvent(eventText);
      }
    } catch (e) {
      logger.AppLogger.error('Error processing SSE chunk', e);
      _buffer = ''; // Clear buffer on error
    }
  }

  /// Process a single SSE event text
  void _processSSEEvent(String eventText) {
    try {
      String? eventData;
      final lines = eventText.split('\n');

      for (final line in lines) {
        if (line.startsWith('data: ')) {
          eventData = line.substring(6).trim();
        }
        // Ignore other SSE fields like 'event:', 'id:', etc.
      }

      if (eventData != null && eventData.isNotEmpty) {
        _processEvent(eventData);
      }
    } catch (e) {
      logger.AppLogger.error('Error processing SSE event text', e);
    }
  }

  /// Process a single SSE event
  void _processEvent(String eventData) {
    try {
      if (eventData.isEmpty) return;

      final json = jsonDecode(eventData) as Map<String, dynamic>;
      final event = SSEEvent.fromJson(json);

      _eventController.add(event);
      logger.AppLogger.debug('SSE event received: ${event.type}');
    } catch (e) {
      logger.AppLogger.error('Error parsing SSE event: data: $eventData', e);
    }
  }

  /// Handle disconnection and schedule reconnect
  void _handleDisconnection() {
    _isConnected = false;
    _subscription?.cancel();
    _subscription = null;

    if (_reconnectAttempts < _maxReconnectAttempts) {
      _scheduleReconnect();
    } else {
      logger.AppLogger.error('Max reconnect attempts reached. Stopping SSE stream.');
      _eventController.add(SSEEvent(
        type: SSEEventType.error,
        data: {'message': 'Connection lost. Max reconnect attempts reached.'},
      ));
    }
  }

  /// Schedule reconnection with exponential backoff
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    _reconnectAttempts++;
    final delay = Duration(
      seconds: (_reconnectDelay.inSeconds * (1 << (_reconnectAttempts - 1)))
          .clamp(0, _maxReconnectDelay.inSeconds),
    );

    logger.AppLogger.info('Scheduling reconnect in ${delay.inSeconds}s (attempt $_reconnectAttempts/$_maxReconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      if (!_isConnected) {
        _connect().catchError((e) {
          logger.AppLogger.error('Reconnect failed', e);
          if (_reconnectAttempts < _maxReconnectAttempts) {
            _scheduleReconnect();
          }
        });
      }
    });
  }

  /// Stop the SSE stream
  Future<void> stop() async {
    logger.AppLogger.info('Stopping SSE stream');
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _reconnectAttempts = 0;
    await _subscription?.cancel();
    _subscription = null;
    _isConnected = false;
  }

  /// Dispose resources
  void dispose() {
    stop();
    _eventController.close();
  }
}
