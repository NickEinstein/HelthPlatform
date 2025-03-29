import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/model/category_model.dart';

import '../app_pkg.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../services/all_service.dart';

// Provider for ArticleService
final articleServiceProvider = Provider<AllService>((ref) {
  final storageService = StorageServiceImpl();
  return AllService(ApiService(), storageService);
});

// FutureProvider for fetching articles

final articleProvider =
    FutureProvider.autoDispose<List<ArticleResponse>>((ref) async {
  final articleService = ref.watch(articleServiceProvider);
  return await articleService.fetchArticles();
});
final bannerProvider = FutureProvider<List<BannerResponse>>((ref) async {
  final articleService = ref.watch(articleServiceProvider);
  return await articleService.fetchBanners();
});

final categoryProvider =
    FutureProvider.autoDispose<List<CategoryResponse>>((ref) async {
  final articleService = ref.watch(articleServiceProvider);
  return await articleService.fetchCategories();
});
