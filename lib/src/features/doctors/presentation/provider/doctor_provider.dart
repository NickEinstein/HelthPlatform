import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/doctors/data/doctor_service.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';

final doctorServiceProvider = Provider<DoctorService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return DoctorService(apiService, storageService);
});
