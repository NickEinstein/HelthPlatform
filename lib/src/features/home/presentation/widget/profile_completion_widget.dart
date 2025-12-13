import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greenzone_medical/src/features/profile/model/patient_profile_result.dart';
import 'package:greenzone_medical/src/features/profile/model/profile_management_screen_model.dart';
import 'package:greenzone_medical/src/features/profile/presentation/profile_management.dart';
import 'package:greenzone_medical/src/provider/profile_provider.dart';
import 'package:greenzone_medical/src/utils/extensions/extensions.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:greenzone_medical/src/utils/packages.dart';

import '../../../../resources/colors/colors.dart';

class ProfileCompletionWidget extends ConsumerStatefulWidget {
  const ProfileCompletionWidget({super.key});

  @override
  ConsumerState<ProfileCompletionWidget> createState() =>
      _ProfileCompletionWidgetState();
}

class _ProfileCompletionWidgetState
    extends ConsumerState<ProfileCompletionWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(patientProfileProvider);
    final immunization = ref.watch(immunizationProvider);
    final allergy = ref.watch(allergyProvider);

    final loading = Container(
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
            InkWell(
              onTap: () {
                context.push(ProfileManagement.routeName,
                    extra: ProfileManagementScreenModel(
                      profile: profile,
                      immunization: immunization,
                      allergies: allergy,
                    ));
              },
              child: Row(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
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
            ),
          ]
        ],
      ),
    );

    Widget body(PatientProfileResult? profileValue) {
      bool isFirstCompleted =
          ((profileValue?.data?.firstName?.isNotEmpty == true) &&
                  (profileValue?.data?.lastName?.isNotEmpty == true)) ||
              (profileValue?.data?.fullName?.isNotEmpty == true);
      bool isSecondCompleted = profileValue?.data?.phoneNumber != null;
      bool isThirdCompleted = profileValue?.data?.nin != null;
      bool isFourthCompleted = profileValue?.data?.dateOfBirth != null &&
          profileValue?.data?.gender?.isNotEmpty == true &&
          profileValue?.data?.nationality?.isNotEmpty == true;
      bool isFifthCompleted =
          profileValue?.data?.stateOfOrigin?.isNotEmpty == true &&
              profileValue?.data?.lga?.isNotEmpty == true &&
              profileValue?.data?.placeOfBirth?.isNotEmpty == true;
      bool isSixthCompleted = profileValue?.data?.weight != null &&
          profileValue?.data?.patientRef?.isNotEmpty == true;
      bool isSeventhCompleted = immunization.maybeWhen(
        data: (value) => value?.isNotEmpty == true,
        orElse: () => false,
      );
      bool isEightCompleted = allergy.maybeWhen(
        data: (value) => value?.isNotEmpty == true,
        orElse: () => false,
      );
      final numCompleted = [
        isFirstCompleted,
        isSecondCompleted,
        isThirdCompleted,
        isFourthCompleted,
        isFifthCompleted,
        isSixthCompleted,
        isSeventhCompleted,
        isEightCompleted
      ].where((v) => v).length;
      const numTotal = 8;
      final percentage = (numCompleted / numTotal * 100).toInt();

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
                    isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            if (isOpen) ...[
              14.height,
              InkWell(
                onTap: () {
                  context.push(ProfileManagement.routeName,
                      extra: ProfileManagementScreenModel(
                        profile: profile,
                        immunization: immunization,
                        allergies: allergy,
                      ));
                },
                child: Row(
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
                            value: percentage / 100,
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
                          '$numCompleted/8',
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            '$percentage% Complete',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]
          ],
        ),
      );
    }

    return profile.when(
      loading: () => loading,
      error: (_, __) => const SizedBox(),
      data: (profile) => body(profile),
    );
  }
}
