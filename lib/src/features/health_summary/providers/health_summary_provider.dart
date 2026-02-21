import 'package:greenzone_medical/src/features/health_summary/providers/health_summary_service.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class HealthSummaryNotifier extends StateNotifier<HealthSummaryState> {
  final Ref ref;
  HealthSummaryNotifier(this.ref) : super(const HealthSummaryState());

  Future<void> getTestStatistics() async {
    try {
      final result =
          await ref.read(healthSummaryServiceProvider).getTestStatistics();
      state = state.copyWith(testStatistics: result);
    } catch (e) {
      state = state.copyWith(testStatistics: []);
    }
  }

  Future<void> getVitalsHistory() async {
    try {
      final result =
          await ref.read(healthSummaryServiceProvider).getVitalsHistory();
      state = state.copyWith(vitalsHistory: result);
    } catch (e) {
      state = state.copyWith(vitalsHistory: []);
    }
  }

  Future<void> getCurrentMedications() async {
    try {
      final result =
          await ref.read(healthSummaryServiceProvider).getCurrentMedications();
      state = state.copyWith(currentMedications: result);
    } catch (e) {
      state = state.copyWith(currentMedications: []);
    }
  }
}

final healthSummaryProvider =
    StateNotifierProvider<HealthSummaryNotifier, HealthSummaryState>((ref) {
  return HealthSummaryNotifier(ref);
});

final healthSummaryServiceProvider = Provider<HealthSummaryService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return HealthSummaryService(apiService, storageService);
});

class HealthSummaryState {
  final List<String> testStatistics;
  final List<String> vitalsHistory;
  final List<String> currentMedications;

  const HealthSummaryState({
    this.testStatistics = const [],
    this.vitalsHistory = const [],
    this.currentMedications = const [],
  });

  HealthSummaryState copyWith({
    List<String>? testStatistics,
    List<String>? vitalsHistory,
    List<String>? currentMedications,
  }) {
    return HealthSummaryState(
      testStatistics: testStatistics ?? this.testStatistics,
      vitalsHistory: vitalsHistory ?? this.vitalsHistory,
      currentMedications: currentMedications ?? this.currentMedications,
    );
  }
}
