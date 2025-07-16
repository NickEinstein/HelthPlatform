import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../resources/resources.dart';
import '../../../../resources/textstyles/app_textstyles.dart';
import '../../models/get_prescriptions_model.dart';
import '../../models/prescription_model.dart';
import '../../providers/prescription_provider.dart';

class SetNewTimeWidget extends ConsumerWidget {
  final PrescriptionByPatientResponse prescription;
  const SetNewTimeWidget({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        SvgPicture.asset(
          SvgAssets.prescriptionSyringe,
        ),
        23.gap,
        Text(
          'Medication Reminder',
          style: CustomTextStyle.textsmall14.w700.withColorHex(0xFF444444),
        ),
        33.gap,
        tile('15 Minutes', () {
          ref.read(presctiptionProvider.notifier).rescheduleReminder(
                prescription: prescription,
                duration: const Duration(minutes: 15),
              );
        }),
        20.gap,
        tile('30 Minutes', () {
          ref.read(presctiptionProvider.notifier).rescheduleReminder(
                prescription: prescription,
                duration: const Duration(minutes: 30),
              );
        }),
        20.gap,
        tile('45 Minutes', () {
          ref.read(presctiptionProvider.notifier).rescheduleReminder(
                prescription: prescription,
                duration: const Duration(minutes: 45),
              );
        }),
        20.gap,
      ],
    );
  }

  Widget tile(
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 40,
        decoration: ShapeDecoration(
          color: const Color(0xFFF4F4F4),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFCCCCCC)),
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Text(
          text,
          style: CustomTextStyle.textsmall14.withColorHex(0xFF181819),
        ),
      ),
    );
  }

  Widget get _divider => const Divider(
        height: 1,
        color: Color(0xffD1D1D1),
      );
}
