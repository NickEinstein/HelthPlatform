import '../../../../provider/all_providers.dart';
import '../../../../utils/packages.dart';

class YourInterestSheet extends ConsumerStatefulWidget {
  const YourInterestSheet({super.key});

  @override
  ConsumerState createState() => _YourInterestSheetState();
}

class _YourInterestSheetState extends ConsumerState<YourInterestSheet> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedGoal = 'Low Sodium to improve heart conditions';
  String? selectedMedicalConcern;

  final Set<int> selectedInterests = {}; // ✅ Changed to int

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void toggleInterest(int interestId) {
    setState(() {
      if (selectedInterests.contains(interestId)) {
        selectedInterests.remove(interestId);
      } else {
        selectedInterests.add(interestId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final communityListAsync = ref.watch(categoryProvider);

    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/hego.png', height: 53, width: 53),
                mediumSpace(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "What are your interests",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff181819),
                    ),
                  ),
                ),
                smallSpace(),

                // Dynamic Interests
                communityListAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      const Center(child: Text('Error loading interest')),
                  data: (communityList) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: communityList.map((community) {
                        final isSelected =
                            selectedInterests.contains(community.id);
                        return GestureDetector(
                          onTap: () => toggleInterest(community.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorConstant.primaryColor
                                  : const Color(0xffE3E5E5)
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: isSelected
                                    ? ColorConstant.primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            child: Text(
                              community.name,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                mediumSpace(),
                mediumSpace(),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedInterests.isEmpty
                                ? Colors.grey
                                : ColorConstant.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: selectedInterests.isEmpty
                              ? null
                              : () async {
                                  ref.read(isLoadingProvider.notifier).state =
                                      true;
                                  final allService =
                                      ref.read(allServiceProvider);
                                  final result =
                                      await allService.saveFavouriteCategoy(
                                    selectedInterests.toList(),
                                  );
                                  if (!context.mounted) return;
                                  ref.read(isLoadingProvider.notifier).state =
                                      false;
                                  if (result == 'successful') {
                                    Navigator.pop(context);
                                    // pop safely // Delay to ensure Navigator stack stabilizes
                                    newShowInfoBottomSheet(
                                      'Notice',
                                      'Records updated successfully.',
                                      buttonText: 'Close',
                                      isAnotherTime: false,
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    CustomToast.show(context, result,
                                        type: ToastType.error);
                                  }
                                },
                          child: const Text(
                            'Update Records',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void newShowInfoBottomSheet(
    String title,
    String message, {
    String buttonText = 'Close',
    bool isAnotherTime = false,
    VoidCallback? onPressed,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icon/hego.png', height: 53, width: 53),
                mediumSpace(),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff181819),
                    ),
                  ),
                ),
                smallSpace(),
                Text(message, textAlign: TextAlign.center),
                mediumSpace(),
                mediumSpace(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: onPressed ??
                        () => Navigator.pop(context), // ✅ Use rootContext
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (isAnotherTime)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // ✅ Use rootContext
                        context.pushReplacement(Routes.BOTTOMNAV);
                      },
                      child: const Text(
                        'I’ll do another time',
                        style: TextStyle(
                            color: Color(0xff999EA2),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
