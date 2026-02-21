import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/all_providers.dart';

class RatingNotifier extends StateNotifier<AsyncValue<String?>> {
  final Ref ref;
  RatingNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<String> rateDoctor({
    required int doctorId,
    required int rating,
    required int ratingTwo,
    required int number,
    required String description,
  }) async {
    state = const AsyncValue.loading();
    try {
      final allService = ref.read(allServiceProvider);
      final result = await allService.doctorRating(
        doctorEmployeeId: doctorId,
        appointmentId: doctorId, // Assuming doctorId is used for appointmentId based on current UI usage
        howAttentiveWasTheDoctorRate: rating,
        howSatisfiedAreYouRate: ratingTwo,
        recommendationRate: number,
        moreDetails: description,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }
}

final ratingProvider =
    StateNotifierProvider<RatingNotifier, AsyncValue<String?>>((ref) {
  return RatingNotifier(ref);
});
