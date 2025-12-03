import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../resources/colors/colors.dart';

class ProfileCompletionWidget extends StatefulWidget {
  const ProfileCompletionWidget({super.key});

  @override
  State<ProfileCompletionWidget> createState() =>
      _ProfileCompletionWidgetState();
}

class _ProfileCompletionWidgetState extends State<ProfileCompletionWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4D2),
        border: Border.all(
          color: const Color(0xFFFFC403),
          width: .75,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.info,
                color: AppColors.primaryVariant,
              ),
              8.width,
              Expanded(
                child: Text(
                  'Profile Completion',
                  style: context.textTheme.labelLarge,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          if (isOpen) ...[
            14.height,
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Completing your profile helps you get the best, personalized experience.',
                        style: context.textTheme.bodySmall,
                      ),
                      8.height,
                      LinearProgressIndicator(
                        value: 0.5,
                        color: AppColors.primaryVariant,
                        backgroundColor: AppColors.greyVariant,
                        borderRadius: BorderRadius.circular(4),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
                12.width,
                Column(
                  children: [
                    Text(
                      '5/8',
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 46,
                      ),
                    ),
                    4.height,
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF29BA2E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        '63% Complete',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
