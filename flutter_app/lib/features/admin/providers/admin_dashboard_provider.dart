import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../data/admin_api_service.dart';
import '../models/admin_stats_model.dart';

// Admin API Service Provider
final adminApiServiceProvider = Provider<AdminApiService>((ref) {
  return AdminApiService();
});

// Admin Repository Provider
final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  final apiService = ref.watch(adminApiServiceProvider);
  return AdminRepository(apiService: apiService);
});

// Dashboard Stats Provider
final adminDashboardStatsProvider = FutureProvider<AdminStats>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  final statsData = await repository.getDashboardStats();
  return AdminStats.fromJson(statsData);
});

// Dashboard Data Provider (includes stats + recent data)
final adminDashboardDataProvider =
    FutureProvider<AdminDashboardData>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  final statsData = await repository.getDashboardStats();

  return AdminDashboardData.fromJson(statsData);
});

// Refresh dashboard data
final adminDashboardRefreshProvider = StateNotifierProvider<
    AdminDashboardRefreshNotifier, AsyncValue<AdminDashboardData>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminDashboardRefreshNotifier(repository);
});

class AdminDashboardRefreshNotifier
    extends StateNotifier<AsyncValue<AdminDashboardData>> {
  final AdminRepository _repository;

  AdminDashboardRefreshNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = const AsyncValue.loading();
    try {
      final statsData = await _repository.getDashboardStats();
      final dashboardData = AdminDashboardData.fromJson(statsData);
      state = AsyncValue.data(dashboardData);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadDashboardData();
  }
}
