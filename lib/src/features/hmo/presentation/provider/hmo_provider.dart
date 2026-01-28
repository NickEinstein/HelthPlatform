import 'package:greenzone_medical/src/features/health_record/data/hmo_service.dart';
import 'package:greenzone_medical/src/features/hmo/models/hmo_model.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

final hmoServiceProvider = Provider.autoDispose<HmoService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return HmoService(apiService, storageService);
});

final userHMOsProvider = FutureProvider.autoDispose<List<HmoModel>>((ref) async {
  final hmoService = ref.watch(hmoServiceProvider);
  return await hmoService.fetchHMOByUserId();
});

