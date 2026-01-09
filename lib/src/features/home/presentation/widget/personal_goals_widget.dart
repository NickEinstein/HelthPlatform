import 'package:flutter/material.dart'
    show Colors, LinearProgressIndicator, InkWell;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/plan/presentation/my_goals_screen.dart';
import 'package:greenzone_medical/src/features/plan/presentation/single_plan_dashboard.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import 'package:greenzone_medical/src/model/regular_app_model.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class PersonalGoalsWidget extends StatefulWidget {
  final List<MyAppModel> myApps;
  const PersonalGoalsWidget({super.key, required this.myApps});

  @override
  State<PersonalGoalsWidget> createState() => _PersonalGoalsWidgetState();
}

class _PersonalGoalsWidgetState extends State<PersonalGoalsWidget> {
  int currentItem = 1;
  late int totalItem;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    totalItem = widget.myApps.length;
    _scrollController = ScrollController()..addListener(_updateCurrentItem);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _updateCurrentItem() {
    if (!mounted) return;
    if (_scrollController.hasClients &&
        (_scrollController.position.pixels.toInt() >
            context.screenWidth * .8)) {
      setState(() {
        currentItem = _scrollController.hasClients
            ? _scrollController.position.pixels.toInt() ~/
                    (context.screenWidth * .8) +
                1
            : 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Your Personal Goals dashboard',
                style: context.textTheme.labelLarge,
              ),
            ),
            Text(
              currentItem.toString(),
              style: context.textTheme.labelLarge,
            ),
            Text(
              ' of $totalItem',
              style: context.textTheme.bodyMedium,
            )
          ],
        ),
        18.height,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            spacing: 12,
            children: List.generate(
              widget.myApps.length,
              (index) => _buildPersonalGoalsItem(widget.myApps[index]),
            ),
          ),
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                context.push(MyGoalsScreen.routeName);
              },
              child: Text(
                'View all goals',
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.greyTextColor2),
              ),
            ),
            // Text(
            //   'View all my friend\'s goals',
            //   style: context.textTheme.bodyMedium
            //       ?.copyWith(color: AppColors.greyTextColor2),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalGoalsItem(MyAppModel item) {
    return InkWell(
      onTap: () {
        context.push(
          SinglePlanDashboard.routeName,
          extra: RegularAppModel.fromApp(item),
        );
      },
      child: SizedBox(
        width: context.screenWidth * .8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(4),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('drugstore'.toSvg),
                        4.width,
                        Text(
                          item.app?.title ??
                              item.goal.substring(0,
                                  item.goal.length > 8 ? 8 : item.goal.length),
                          style: context.textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                (context.screenWidth * .1).width,
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40A7A7A7),
                    blurRadius: 11,
                    offset: Offset(0, 4),
                  )
                ],
                color: Colors.white,
                border: Border.all(
                  color: AppColors.primaryVariant,
                  width: .7,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    26.height,
                                    Text(
                                      '0%',
                                      style: context.textTheme.labelLarge
                                          ?.copyWith(
                                        fontSize: 46,
                                      ),
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'goal'.toSvg,
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                            4.height,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Percentage of Goal Achieved',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('days_completed'.toSvg),
                                  2.width,
                                  Text(
                                    '0',
                                    style: context.textTheme.displayLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Days completed',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                  color: AppColors.greyTextColor,
                                ),
                              ),
                            ],
                          ),
                          12.height,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('coins'.toSvg),
                                  2.width,
                                  Text(
                                    '0',
                                    style: context.textTheme.displayLarge,
                                  ),
                                ],
                              ),
                              Text(
                                'Earned Coins',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 11,
                                  color: AppColors.greyTextColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  18.height,
                  const LinearProgressIndicator(
                    value: 0,
                    color: AppColors.primaryVariant,
                    backgroundColor: AppColors.greyVariant,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
