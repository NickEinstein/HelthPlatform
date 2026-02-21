import '../../../provider/all_providers.dart';
import '../../../utils/packages.dart';
import '../../appointment/model/appointment_model.dart';

class RatingPage extends ConsumerStatefulWidget {
  final AppointmentResponse doctor; // Accept doctor data
  const RatingPage({super.key, required this.doctor});

  @override
  ConsumerState<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends ConsumerState<RatingPage> {
  final TextEditingController descriptionController = TextEditingController();
  int _selectedRating = 0;

  void _onStarTapped(int index) {
    setState(() {
      _selectedRating = index + 1;
    });
  }

  int _selectedRatingTwo = 0;

  void _onStarTappedTwo(int index) {
    setState(() {
      _selectedRatingTwo = index + 1;
    });
  }

  int _selectedNumber = 0;

  void _onNumberTapped(int index) {
    setState(() {
      _selectedNumber = index + 1; // Since index is 0-based, add 1
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, 0.08),
              CustomHeader(
                title: 'Doctor’s Rating',
                onPressed: () {
                  // Handle back button press
                  Navigator.pop(context);
                },
              ),
              mediumSpace(),
              const Text(
                  "How well did the doctor listen to your concerns and explain things in a clear, understandable way?",
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.w400)),
              mediumSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => _onStarTapped(index),
                    child: Icon(
                      _selectedRating > index ? Icons.star : Icons.star,
                      color: _selectedRating > index
                          ? const Color(0xffFFC403)
                          : const Color(0xffD9D9D9),
                      size: 40.0,
                    ),
                  );
                }),
              ),
              mediumSpace(),
              const Text(
                  "How satisfied are you with the care and treatment provided during your visit?",
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.w400)),
              mediumSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => _onStarTappedTwo(index),
                    child: Icon(
                      _selectedRatingTwo > index ? Icons.star : Icons.star,
                      color: _selectedRatingTwo > index
                          ? const Color(0xffFFC403)
                          : const Color(0xffD9D9D9),
                      size: 40.0,
                    ),
                  );
                }),
              ),
              mediumSpace(),
              const Text(
                  "How likely are you to recommend this doctor to family or friends?",
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.secondryColor,
                      fontWeight: FontWeight.w400)),
              mediumSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => _onNumberTapped(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedNumber > index
                              ? const Color(0xffB4F0B6)
                              : const Color(0xffD9D9D9),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: _selectedNumber > index
                            ? const Color(0xffB4F0B6)
                            : const Color(0xffD9D9D9),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _selectedNumber > index
                                ? const Color(0xff059909)
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              smallSpace(),
              // BookingCalendar(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("(Rating: 1 - Not likely at all, 5 - Extremely likely)",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Color(0xff616060),
                          fontWeight: FontWeight.w400)),
                ],
              ),
              // context.push(Routes.RATINGPAGE, extra: doctor);

              mediumSpace(),

              CustomLongTextField(
                label: "Tell us more about his service",
                hint: "Tell us more about his service",
                controller: descriptionController,
              ),
              verticalSpace(context, 0.04),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        foregroundColor: ColorConstant.primaryColor,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        // print(widget.doctor.toJson());
                        if (_selectedRating > 0 &&
                            _selectedRatingTwo > 0 &&
                            _selectedNumber > 0 &&
                            descriptionController.text.isNotEmpty) {
                          ref.read(isLoadingProvider.notifier).state = true;

                          final allService = ref.read(allServiceProvider);

                          // Null check for healthCareProviderId and doctorId
                          if (widget.doctor.id == null) {
                            CustomToast.show(context,
                                'Select and tell us about the service.',
                                type: ToastType.error);
                            ref.read(isLoadingProvider.notifier).state =
                                false; // Stop loading if error
                            return;
                          }

                          final result = await allService.doctorRating(
                            howAttentiveWasTheDoctorRate: _selectedRating,
                            howSatisfiedAreYouRate: _selectedRatingTwo,
                            recommendationRate: _selectedNumber,
                            moreDetails: descriptionController.text,
                            appointmentId: widget.doctor.id!,
                            doctorEmployeeId: widget.doctor.doctorId!,
                          );

                          if (!context.mounted) {
                            return; // Prevents using context if unmounted
                          }
                          ref.read(isLoadingProvider.notifier).state =
                              false; // Stop loading

                          if (result == 'successful') {
                            showInfoBottomSheet(
                              context,
                              '',
                              'Thank you for rating Dr. ${widget.doctor.doctor}.',
                              buttonText: 'Close',
                              isAnotherTime: false,
                              onPressed: () async {
                                Navigator.pop(context);
                                context.pushReplacement(Routes.BOTTOMNAV);
                              },
                            );
                          } else {
                            CustomToast.show(context, result,
                                type: ToastType.error);
                          }
                        } else if (_selectedRating == 0) {
                          CustomToast.show(context,
                              'How well did the doctor listen to your concern?',
                              type: ToastType.error);
                        } else if (_selectedRatingTwo == 0) {
                          CustomToast.show(context,
                              'How satisfied are you with the treatment?',
                              type: ToastType.error);
                        } else if (_selectedRatingTwo == 0) {
                          CustomToast.show(
                              context, 'How likely are you to recommend?',
                              type: ToastType.error);
                        } else if (descriptionController.text.isEmpty ||
                            descriptionController.text.length < 5) {
                          CustomToast.show(
                              context, 'Please tell us more about his service',
                              type: ToastType.error);
                        }
                      },
                      child: const Text(
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white),
                          "Submit Review"),
                    ),
              mediumSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
