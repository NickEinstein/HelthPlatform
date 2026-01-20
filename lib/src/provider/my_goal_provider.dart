import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/plan/models/user_journal_model.dart';
import 'package:greenzone_medical/src/model/my_app_category_model.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/services/goal_service.dart';

final myGoalServiceProvider = Provider<GoalService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);

  return GoalService(apiService, storageService);
});

class GoalState {
  final AsyncValue<List<MyAppCategoryModel>>? categories;
  final AsyncValue<List<RegularAppModel>>? allApps;
  final AsyncValue<List<MyAppModel>>? myApps;

  GoalState({
    this.categories = const AsyncValue.loading(),
    this.allApps = const AsyncValue.loading(),
    this.myApps = const AsyncValue.loading(),
  });

  GoalState copyWith({
    AsyncValue<List<MyAppCategoryModel>>? categories,
    AsyncValue<List<RegularAppModel>>? allApps,
    AsyncValue<List<MyAppModel>>? myApps,
  }) {
    return GoalState(
      categories: categories ?? this.categories,
      allApps: allApps ?? this.allApps,
      myApps: myApps ?? this.myApps,
    );
  }
}

class GoalNotifier extends Notifier<GoalState> {
  late final GoalService _goalService;

  @override
  GoalState build() {
    _goalService = ref.watch(myGoalServiceProvider);
    return GoalState();
  }

  Future<void> getAppCategories() async {
    state = state.copyWith(categories: const AsyncValue.loading());
    try {
      final categories = await _goalService.getAppCategories();
      state = state.copyWith(categories: AsyncValue.data(categories));
    } catch (e, stack) {
      state = state.copyWith(categories: AsyncValue.error(e, stack));
    }
  }

  Future<void> getAllApps() async {
    state = state.copyWith(allApps: const AsyncValue.loading());
    try {
      final apps = await _goalService.getAllApps();
      state = state.copyWith(allApps: AsyncValue.data(apps));
    } catch (e, stack) {
      state = state.copyWith(allApps: AsyncValue.error(e, stack));
    }
  }

  Future<void> getMyApps() async {
    state = state.copyWith(myApps: const AsyncValue.loading());
    try {
      final apps = await _goalService.getMyApps();
      state = state.copyWith(myApps: AsyncValue.data(apps));
    } catch (e, stack) {
      state = state.copyWith(myApps: AsyncValue.error(e, stack));
    }
  }

  Future<List<RegularAppModel>> getAppsByCategory(int? id) async {
    try {
      return await _goalService.getAppsByCategory(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<RegularAppModel?> getSingleApp(int id) async {
    try {
      return await _goalService.getSingleApp(id);
    } catch (e) {
      return null;
    }
  }

  Future<List<UserJournalModel>> getUserJournal(int id) async {
    try {
      return await _goalService.getUserGoalJournals(id);
    } catch (e) {
      return [];
    }
  }
}

final goalNotifierProvider =
    NotifierProvider<GoalNotifier, GoalState>(GoalNotifier.new);

final goalByCategoryProvider =
    FutureProvider.family<List<RegularAppModel>, int?>((ref, id) {
  return ref.watch(goalNotifierProvider.notifier).getAppsByCategory(id);
});

final singlePlanProvider = FutureProvider.family<RegularAppModel?, int>((ref, id) {
  return ref.watch(goalNotifierProvider.notifier).getSingleApp(id);
});

final userJournalProvider = FutureProvider.family<List<UserJournalModel>, int>((ref, id) {
  return ref.watch(goalNotifierProvider.notifier).getUserJournal(id);
});