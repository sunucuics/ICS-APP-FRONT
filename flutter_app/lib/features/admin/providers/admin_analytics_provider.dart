import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../models/admin_analytics_model.dart';
import '../models/admin_filter_model.dart';
import 'admin_dashboard_provider.dart';

final adminAnalyticsProvider =
    FutureProvider.family<AnalyticsData, Map<String, dynamic>>(
        (ref, params) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getAnalytics(
    period: params['period'] as String?,
    startDate: params['startDate'] as DateTime?,
    endDate: params['endDate'] as DateTime?,
  );
});

class AdminAnalyticsNotifier extends StateNotifier<AsyncValue<AnalyticsData>> {
  final AdminRepository _repository;

  AdminAnalyticsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchAnalytics({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final analytics = await _repository.getAnalytics(
        period: period,
        startDate: startDate,
        endDate: endDate,
      );
      state = AsyncValue.data(analytics);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> exportReport(String format) async {
    try {
      final exportOptions = ExportOptions(
        format: format,
        includeHeaders: true,
      );
      await _repository.exportData('analytics', exportOptions);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    await fetchAnalytics();
  }
}

final adminAnalyticsNotifierProvider =
    StateNotifierProvider<AdminAnalyticsNotifier, AsyncValue<AnalyticsData>>(
        (ref) {
  return AdminAnalyticsNotifier(ref.watch(adminRepositoryProvider));
});
