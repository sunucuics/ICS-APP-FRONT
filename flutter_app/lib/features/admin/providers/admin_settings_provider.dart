import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../models/admin_settings_model.dart';
import 'admin_dashboard_provider.dart';

final adminSystemSettingsProvider = FutureProvider<SystemSettings>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getSystemSettings();
});

final adminEmailTemplatesProvider =
    FutureProvider<List<EmailTemplate>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getEmailTemplates();
});

class AdminSettingsNotifier extends StateNotifier<AsyncValue<SystemSettings>> {
  final AdminRepository _repository;

  AdminSettingsNotifier(this._repository) : super(const AsyncValue.loading()) {
    _fetchSettings();
  }

  Future<void> _fetchSettings() async {
    state = const AsyncValue.loading();
    try {
      final settings = await _repository.getSystemSettings();
      state = AsyncValue.data(settings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateAppSettings(Map<String, dynamic> settingsData) async {
    try {
      await _repository.updateAppSettings(settingsData);
      await _fetchSettings();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePaymentSettings(Map<String, dynamic> settingsData) async {
    try {
      await _repository.updatePaymentSettings(settingsData);
      await _fetchSettings();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    await _fetchSettings();
  }
}

final adminSettingsNotifierProvider =
    StateNotifierProvider<AdminSettingsNotifier, AsyncValue<SystemSettings>>(
        (ref) {
  return AdminSettingsNotifier(ref.watch(adminRepositoryProvider));
});

class AdminEmailTemplatesNotifier
    extends StateNotifier<AsyncValue<List<EmailTemplate>>> {
  final AdminRepository _repository;

  AdminEmailTemplatesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    _fetchTemplates();
  }

  Future<void> _fetchTemplates() async {
    state = const AsyncValue.loading();
    try {
      final templates = await _repository.getEmailTemplates();
      state = AsyncValue.data(templates);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createTemplate(Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createEmailTemplate(templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateEmailTemplate(templateId, templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTemplate(String templateId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteEmailTemplate(templateId);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await _fetchTemplates();
  }
}

final adminEmailTemplatesNotifierProvider = StateNotifierProvider<
    AdminEmailTemplatesNotifier, AsyncValue<List<EmailTemplate>>>((ref) {
  return AdminEmailTemplatesNotifier(ref.watch(adminRepositoryProvider));
});
