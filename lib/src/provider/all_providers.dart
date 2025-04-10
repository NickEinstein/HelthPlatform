import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/prescription/models/get_prescriptions_model.dart';
import 'package:greenzone_medical/src/model/all_alergy_response.dart';
import 'package:greenzone_medical/src/model/category_model.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/model/doctord_list_response.dart';
import 'package:greenzone_medical/src/model/nationality_model.dart';
import 'package:greenzone_medical/src/model/state_model.dart';

import '../app_pkg.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../services/all_service.dart';

// Provider for ArticleService
final isLoadingProvider = StateProvider<bool>((ref) => false);
final isAgreedProvider = StateProvider<bool>((ref) => false);

final allServiceProvider = Provider<AllService>((ref) {
  final storageService = StorageServiceImpl();
  return AllService(ApiService(), storageService);
});

// FutureProvider for fetching articles

final articleProvider =
    FutureProvider.autoDispose<List<ArticleResponse>>((ref) async {
  final articleService = ref.watch(allServiceProvider);
  return await articleService.fetchArticles();
});
final bannerProvider = FutureProvider<List<BannerResponse>>((ref) async {
  final bannerService = ref.watch(allServiceProvider);
  return await bannerService.fetchBanners();
});
// final stateListProvider = FutureProvider<List<StateData>>((ref) async {
//   final stateListService = ref.watch(authServiceProvider);
//   return await stateListService.fetchState();
// });
final nationalityListProvider =
    FutureProvider<List<NationalityData>>((ref) async {
  final nationalityListService = ref.watch(authServiceProvider);
  return await nationalityListService.fetchNationality();
});
final categoryProvider =
    FutureProvider.autoDispose<List<CategoryResponse>>((ref) async {
  final categoryService = ref.watch(allServiceProvider);
  return await categoryService.fetchCategories();
});
final doctorListProvider =
    FutureProvider.autoDispose<List<DoctorListResponse>>((ref) async {
  final doctorListService = ref.watch(allServiceProvider);
  return await doctorListService.fetchDoctorList();
});
final communityListProvider =
    FutureProvider.autoDispose<List<CommunityListResponse>>((ref) async {
  final communityListService = ref.watch(allServiceProvider);
  return await communityListService.fetchCommunityList();
});
final loginDataProvider = FutureProvider.autoDispose<String?>((ref) async {
  final loginDataService = ref.watch(authServiceProvider);
  return await loginDataService.getLoginData();
});

final allAllegyListProvider =
    FutureProvider.autoDispose<List<AllAlergyResponse>>((ref) async {
  final allAllegyLListService = ref.watch(allServiceProvider);
  return await allAllegyLListService.fetchAllergies();
});
final allIntolleranceListProvider =
    FutureProvider.autoDispose<List<AllAlergyResponse>>((ref) async {
  final allIntolleranceegyLListService = ref.watch(allServiceProvider);
  return await allIntolleranceegyLListService.fetchIntollerance();
});
final allPrescriptionsListProvider =
    FutureProvider.autoDispose<List<GetPrescriptionModel>>((ref) async {
  final allPrescriptionListService = ref.watch(allServiceProvider);
  return await allPrescriptionListService.getPrescriptions();
});
