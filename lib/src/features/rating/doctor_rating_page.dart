import '../../provider/all_providers.dart';
import '../../utils/packages.dart';
import '../appointment/model/appointment_model.dart';

class DoctorRatingPage extends ConsumerStatefulWidget {
  final AppointmentResponse? doctor;
  final String? doctorName;
  final String? doctorId;
  const DoctorRatingPage({
    super.key,
    this.doctor,
    this.doctorId,
    this.doctorName,
  });

  @override
  ConsumerState<DoctorRatingPage> createState() => _DoctorRatingPageState();
}

class _DoctorRatingPageState extends ConsumerState<DoctorRatingPage> {
  final TextEditingController descriptionController = TextEditingController();
  int _selectedRating = 0;
  int _selectedRatingTwo = 0;
  int _selectedNumber = 0;

  void _onStarTapped(int index) {
    setState(() {
      _selectedRating = index + 1;
    });
  }

  void _onStarTappedTwo(int index) {
    setState(() {
      _selectedRatingTwo = index + 1;
    });
  }

  void _onNumberTapped(int index) {
    setState(() {
      _selectedNumber = index + 1;
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CustomHeader(
          title: "Doctor's Rating",
          onPressed: () => Navigator.pop(context),
          onSearchPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Question 1: Listening & Explanation ──
            const Text(
              "How well did the doctor listen to your concerns and explain things in a clear, understandable way?",
              style: TextStyle(
                fontSize: 15,
                color: ColorConstant.secondryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _onStarTapped(index),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.star,
                      color: _selectedRating > index
                          ? const Color(0xffFFC403)
                          : const Color(0xffD9D9D9),
                      size: 38,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // ── Question 2: Care & Treatment ──
            const Text(
              "How satisfied are you with the care and treatment provided during your visit?",
              style: TextStyle(
                fontSize: 15,
                color: ColorConstant.secondryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _onStarTappedTwo(index),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      Icons.star,
                      color: _selectedRatingTwo > index
                          ? const Color(0xffFFC403)
                          : const Color(0xffD9D9D9),
                      size: 38,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // ── Question 3: Recommendation ──
            const Text(
              "How likely are you to recommend this doctor to family or friends?",
              style: TextStyle(
                fontSize: 15,
                color: ColorConstant.secondryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(5, (index) {
                final isActive = _selectedNumber > index;
                return GestureDetector(
                  onTap: () => _onNumberTapped(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xffB4F0B6)
                          : const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive
                            ? const Color(0xffB4F0B6)
                            : const Color(0xffD9D9D9),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color:
                              isActive ? const Color(0xff059909) : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            const Text(
              "(Rating: 1 - Not likely at all, 5 - Extremely likely)",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13,
                color: Color(0xff616060),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),

            // ── Service Feedback Text Field ──
            CustomLongTextField(
              label: "Tell us more about his service",
              hint: "Tell us more about his service",
              controller: descriptionController,
            ),
            const SizedBox(height: 30),

            // ── Submit Button ──
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        if (_selectedRating == 0) {
                          CustomToast.show(
                            context,
                            'How well did the doctor listen to your concern?',
                            type: ToastType.error,
                          );
                          return;
                        }
                        if (_selectedRatingTwo == 0) {
                          CustomToast.show(
                            context,
                            'How satisfied are you with the treatment?',
                            type: ToastType.error,
                          );
                          return;
                        }
                        if (_selectedNumber == 0) {
                          CustomToast.show(
                            context,
                            'How likely are you to recommend?',
                            type: ToastType.error,
                          );
                          return;
                        }
                        if (descriptionController.text.isEmpty ||
                            descriptionController.text.length < 5) {
                          CustomToast.show(
                            context,
                            'Please tell us more about his service',
                            type: ToastType.error,
                          );
                          return;
                        }

                        if ((widget.doctor?.id ?? widget.doctorId) == null) {
                          CustomToast.show(
                            context,
                            'Select and tell us about the service.',
                            type: ToastType.error,
                          );
                          return;
                        }

                        ref.read(isLoadingProvider.notifier).state = true;

                        final allService = ref.read(allServiceProvider);

                        final result = await allService.doctorRating(
                          howAttentiveWasTheDoctorRate: _selectedRating,
                          howSatisfiedAreYouRate: _selectedRatingTwo,
                          recommendationRate: _selectedNumber,
                          moreDetails: descriptionController.text,
                          appointmentId: widget.doctor?.id ??
                              int.tryParse(widget.doctorId ?? "") ??
                              -1,
                          doctorEmployeeId: widget.doctor?.doctorId ??
                              int.tryParse(widget.doctorId ?? "") ??
                              -1,
                        );

                        if (!context.mounted) return;
                        ref.read(isLoadingProvider.notifier).state = false;

                        if (result == 'successful') {
                          showInfoBottomSheet(
                            context,
                            '',
                            'Thank you for rating Dr. ${widget.doctor?.doctor ?? widget.doctorName}.',
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
                      },
                      child: const Text(
                        "Submit Review",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
