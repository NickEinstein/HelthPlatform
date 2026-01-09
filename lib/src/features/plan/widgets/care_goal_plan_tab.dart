import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/plan/widgets/plan_tab_dashboard.dart';
import 'package:greenzone_medical/src/features/plan/widgets/populated_plan_tab.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/loading_widget.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

class CareGoalPlanTab extends ConsumerStatefulWidget {
  final RegularAppModel myApp;
  const CareGoalPlanTab({super.key, required this.myApp});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CareGoalPlanTabState();
}

class _CareGoalPlanTabState extends ConsumerState<CareGoalPlanTab> {
  bool getStartedPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);
    final userGoal = ref.watch(goalNotifierProvider.select(
      (s) => s.allApps ?? const AsyncValue.data([]),
    ));

    return SingleChildScrollView(
      child: FutureBuilder(
        future: authService.getStoredUser(),
        builder: (context, snapshot) {
          String userName = "User"; // Default name
          if (snapshot.hasData && snapshot.data != null) {
            userName = snapshot.data!.name;
          }

          return userGoal.when(
            data: (data) {
              final isStarted =
                  data.any((element) => element.id == widget.myApp.id);
              return isStarted
                  ? const PlanTabDashboard()
                  : getStartedPressed
                      ? PlanTab(
                          model: widget.myApp,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _buildGetStartedTab(
                            context,
                            userName: userName,
                          ),
                        );
            },
            loading: () => const ListLoader(
              itemCount: 1,
            ),
            error: (error, stackTrace) => ErrorWidget(error),
          );
        },
      ),
    );
  }

  _buildGetStartedTab(
    BuildContext context, {
    required String userName,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello $userName,',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          20.height,
          Text(
            widget.myApp.description,
            style: context.textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
          // Text(
          //   'We are excited about your aspiration and desire to give your hair the attention it deserves.',
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          // 20.height,
          // Text(
          //   "What's most exciting is that we'll be a part of this journey with you.",
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          // 20.height,
          // Text(
          //   "Let's get you started on a plan for your hair.",
          //   style: context.textTheme.bodyLarge?.copyWith(
          //     height: 1.5,
          //   ),
          // ),
          40.height,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  getStartedPressed = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF109615), // Darker green
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Let's Get Started",
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
}
