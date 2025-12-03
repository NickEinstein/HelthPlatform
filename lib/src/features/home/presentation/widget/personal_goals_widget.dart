import 'package:flutter/material.dart' show Colors, LinearProgressIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenzone_medical/src/resources/colors/colors.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/string_extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class PersonalGoalsWidget extends StatefulWidget {
  const PersonalGoalsWidget({super.key});

  @override
  State<PersonalGoalsWidget> createState() => _PersonalGoalsWidgetState();
}

class _PersonalGoalsWidgetState extends State<PersonalGoalsWidget> {
  int currentItem = 1;
  int totalItem = 5;

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
          child: Row(
            spacing: 12,
            children: List.generate(
              4,
              (index) => _buildPersonalGoalsItem(),
            ),
          ),
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'View all my goals',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.greyTextColor2),
            ),
            Text(
              'View all my friend\'s goals',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.greyTextColor2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalGoalsItem() {
    return SizedBox(
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
                      Text('Hair Care Self-Care App',
                          style: context.textTheme.labelMedium),
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
                                    '36%',
                                    style:
                                        context.textTheme.labelLarge?.copyWith(
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
                                  '12',
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
                                  '3112',
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
                  value: .8,
                  color: AppColors.primaryVariant,
                  backgroundColor: AppColors.greyVariant,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
