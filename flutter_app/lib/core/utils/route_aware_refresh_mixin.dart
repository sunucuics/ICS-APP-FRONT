import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global RouteObserver instance - should be initialized in main.dart
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// Mixin for ConsumerState widgets that need to refresh providers when route becomes visible
/// 
/// Usage:
/// ```dart
/// class MyPage extends ConsumerStatefulWidget {
///   const MyPage({super.key});
///   
///   @override
///   ConsumerState<MyPage> createState() => _MyPageState();
/// }
/// 
/// class _MyPageState extends ConsumerState<MyPage> with RouteAware, RouteAwareRefreshMixin {
///   @override
///   void onRouteVisible() {
///     // Refresh providers when page becomes visible
///     ref.invalidate(myProvider);
///   }
/// }
/// ```
mixin RouteAwareRefreshMixin<T extends ConsumerStatefulWidget> on ConsumerState<T>, RouteAware {
  bool _isInitialLoad = true;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final modalRoute = ModalRoute.of(context);
    if (modalRoute is PageRoute) {
      routeObserver.subscribe(this, modalRoute);
    }
  }
  
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
  
  @override
  void didPush() {
    // Route was pushed onto navigator
    // This is called on initial load, so we skip it to avoid unnecessary refresh
    _isInitialLoad = false;
  }
  
  @override
  void didPopNext() {
    // Route popped off, this route is now visible
    // User navigated back to this page
    if (!_isInitialLoad && mounted) {
      onRouteVisible();
    }
  }
  
  @override
  void didPushNext() {
    // Route pushed next, this route is no longer visible
  }
  
  @override
  void didPop() {
    // Route was popped
  }
  
  /// Override this method to refresh providers when the route becomes visible
  void onRouteVisible() {
    // Override in your widget to refresh providers
  }
}

