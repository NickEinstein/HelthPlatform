import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/features/home/presentation/widget/personal_goals_widget.dart';
import 'package:greenzone_medical/src/features/plan/presentation/my_goals_screen.dart';
import 'package:greenzone_medical/src/provider/my_goal_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class HealthGoalWidget extends ConsumerStatefulWidget {
  const HealthGoalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HealthGoalWidgetState();
}

class _HealthGoalWidgetState extends ConsumerState<HealthGoalWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goalNotifierProvider.notifier).getMyApps();
      ref.read(goalNotifierProvider.notifier).getAllApps();
    });
  }

  @override
  Widget build(BuildContext context) {
    final myApps = ref.watch(
      goalNotifierProvider.select((s) => s.myApps),
    );
    final allApps = ref.watch(
      goalNotifierProvider.select((s) => s.allApps),
    );
    final loadingWidget = Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red,
      ),
    ).shimmer();

    return myApps?.when(
          data: (data) {
            if (data.isEmpty) {
              return noHealthGoalWidget(context);
            } else {
              return allApps?.when(
                    data: (allData) {
                      return PersonalGoalsWidget(
                          myApps: data
                              .map((e) => e.copyWith(
                                    app: allData
                                        .where(
                                            (element) => element.id == e.appId)
                                        .firstOrNull,
                                  ))
                              .toList());
                    },
                    loading: () => loadingWidget,
                    error: (error, stackTrace) => const SizedBox.shrink(),
                  ) ??
                  const SizedBox.shrink();
            }
          },
          loading: () => loadingWidget,
          error: (error, stackTrace) => const SizedBox.shrink(),
        ) ??
        const SizedBox.shrink();
  }
}

Widget noHealthGoalWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hey, you don\'t seem to have any health goals',
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      12.height,
      InkWell(
        onTap: () {
          context.push(MyGoalsScreen.routeName);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffEAFFEB),
            border: Border.all(
              color: ColorConstant.primaryColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'health_goal'.toSvg,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'We have a bank of goals you can select from, starting with simple things like your hair to medical goals.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    8.height,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xFF29BA2E),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: Text(
                        'Get started now!',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
