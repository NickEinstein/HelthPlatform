import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/model/my_app_category_model.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/services/my_app_service.dart';

final myAppServiceProvider = Provider<MyAppService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);

  return MyAppService(apiService, storageService);
});

final appCategoryProvider = FutureProvider<List<MyAppCategoryModel>>((ref) {
  final myAppService = ref.watch(myAppServiceProvider);
  return myAppService.getAppCategories();
});

final appByCategoryProvider =
    FutureProvider.family<List<MyAppModel>, int?>((ref, id) {
  final myAppService = ref.watch(myAppServiceProvider);
  return myAppService.getAppsByCategory(id);
});

final myAppsProvider = FutureProvider((ref) {
  final myAppService = ref.watch(myAppServiceProvider);
  return myAppService.getMyApps();
});
