import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/healthgoal/controller/health_goal_controller.dart';
import 'package:greenzone_medical/src/features/healthgoal/presentation/widget/food_alergy.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../provider/all_providers.dart';
import '../../../routes/routes.dart';
import '../../../utils/custom_toast.dart';
import '../../community/presentation/community_details.dart';
import 'widget/tolerance.dart';

final healthGoalControllerProvider = ChangeNotifierProvider((ref) {
  return HealthGoalController();
});

class AboutGoalPage extends ConsumerStatefulWidget {
  const AboutGoalPage({super.key});

  @override
  ConsumerState<AboutGoalPage> createState() => _AboutGoalPageState();
}

class _AboutGoalPageState extends ConsumerState<AboutGoalPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  String title = 'Dietary Restrictions';
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  void initState() {
    super.initState();
    // Reset the controller's selections on first page load
    final _controller = ref.read(healthGoalControllerProvider);
    _controller.resetSelections();
  }

  void _nextPage() async {
    final currentFormState = _formKeys[_currentIndex].currentState;
    final _controller = ref.watch(healthGoalControllerProvider);

    if (_currentIndex == 0) {
      if (_controller.foodAllegy == 'No') {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (_controller.foodAllegy == 'Yes') {
        if (_controller.selectedAllergies.isEmpty) {
          CustomToast.show(context, 'Select an allergy', type: ToastType.error);
          return;
        }
        ref.read(isLoadingProvider.notifier).state = true; // ✅ Start loading

        final allService = ref.read(allServiceProvider);
        final result = await allService.updateAllergies(
          selectedAllergies: _controller.selectedAllergies,
          otherController: _controller.otherController,
        );

        if (!context.mounted) return;
        ref.read(isLoadingProvider.notifier).state = false; // ✅ Stop loading

        if (result == 'successful') {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          CustomToast.show(context, result, type: ToastType.error);
        }
      } else {
        CustomToast.show(context, 'Select an option', type: ToastType.error);
      }
    } else if (_currentIndex == 1) {
      if (_controller.interllories == 'No') {
        context.pushReplacement(Routes.BOTTOMNAV);
      } else if (_controller.interllories == 'Yes') {
        if (_controller.selectedIntellories.isEmpty) {
          CustomToast.show(context, 'Select intolerance',
              type: ToastType.error);
          return;
        }
        ref.read(isLoadingProvider.notifier).state = true; // ✅ Start loading

        final allService = ref.read(allServiceProvider);
        final result = await allService.updateIntollerance(
          selectedIntollerance: _controller.selectedIntellories,
        );

        if (!context.mounted) return;
        ref.read(isLoadingProvider.notifier).state = false; // ✅ Stop loading

        if (result == 'successful') {
          context.pushReplacement(Routes.BOTTOMNAV);
        } else {
          CustomToast.show(context, result, type: ToastType.error);
        }
      } else {
        CustomToast.show(context, 'Select an option', type: ToastType.error);
      }
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final _controller = ref.watch(healthGoalControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white, // Matching the UI
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 6),
                      decoration: BoxDecoration(
                        color: ColorConstant.primaryLightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.keyboard_arrow_left_rounded,
                          color: Colors.white),
                    ),
                  ),
                  if (title != null) ...[
                    const SizedBox(width: 12),
                    Text(
                      _currentIndex == 0 ? title : 'Histamine Tolerance',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3C3B3B)),
                    ),
                  ],
                ],
              ),
              verticalSpace(context, 0.04),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: [
                    FoodAlergy(
                        onNext: _nextPage,
                        formKey: _formKeys[0],
                        controller: _controller),
                    TolerancePage(
                        onNext: _nextPage,
                        formKey: _formKeys[1],
                        controller: _controller),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getButtonColor(_controller),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _nextPage,
                        child: Text(
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                          _currentIndex == 2 ? "Create Account" : "Continue",
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(HealthGoalController _controller) {
    if (_currentIndex == 0) {
      if (_controller.foodAllegy == 'Yes' &&
          _controller.selectedAllergies.isNotEmpty) {
        return ColorConstant.primaryColor; // Active button
      }
      if (_controller.foodAllegy == 'No') {
        return ColorConstant.primaryColor; // Active button
      }
      return ColorConstant.primaryLightColor
          .withOpacity(0.3); // Disabled button
    }

    if (_currentIndex == 1) {
      if (_controller.interllories == 'Yes' &&
          _controller.selectedIntellories.isNotEmpty) {
        return ColorConstant.primaryColor; // Active button
      }
      if (_controller.interllories == 'No') {
        return ColorConstant.primaryColor; // Active button
      }
      return ColorConstant.primaryLightColor
          .withOpacity(0.3); // Disabled button
    }

    return ColorConstant.primaryColor; // Default color
  }
}
