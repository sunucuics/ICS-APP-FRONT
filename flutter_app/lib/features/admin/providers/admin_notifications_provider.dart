import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../models/admin_notification_model.dart';
import 'admin_dashboard_provider.dart';

final adminNotificationTemplatesProvider =
    FutureProvider<List<NotificationTemplate>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getNotificationTemplates();
});

final adminNotificationCampaignsProvider =
    FutureProvider<List<NotificationCampaign>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getNotificationCampaigns();
});

final adminUserSegmentsProvider =
    FutureProvider<List<UserSegment>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getUserSegments();
});

class AdminNotificationTemplatesNotifier
    extends StateNotifier<AsyncValue<List<NotificationTemplate>>> {
  final AdminRepository _repository;

  AdminNotificationTemplatesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    _fetchTemplates();
  }

  Future<void> _fetchTemplates() async {
    state = const AsyncValue.loading();
    try {
      final templates = await _repository.getNotificationTemplates();
      state = AsyncValue.data(templates);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createTemplate(Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createNotificationTemplate(templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateNotificationTemplate(templateId, templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTemplate(String templateId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteNotificationTemplate(templateId);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendNotification(
    String title,
    String body,
    String? templateId,
    List<String> segments,
  ) async {
    try {
      final notificationRequest = NotificationRequest(
        title: title,
        body: body,
        templateId: templateId,
        userSegments: segments.isNotEmpty ? segments : null,
        sendImmediately: true,
      );
      await _repository.sendNotification(notificationRequest);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    await _fetchTemplates();
  }
}

final adminNotificationTemplatesNotifierProvider = StateNotifierProvider<
    AdminNotificationTemplatesNotifier,
    AsyncValue<List<NotificationTemplate>>>((ref) {
  return AdminNotificationTemplatesNotifier(ref.watch(adminRepositoryProvider));
});
