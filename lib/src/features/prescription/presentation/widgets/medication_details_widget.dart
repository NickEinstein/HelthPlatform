import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../resources/resources.dart';
import '../../../../resources/textstyles/app_textstyles.dart';
import '../../../../routes/old_routes.dart';
import '../../models/get_prescriptions_model.dart';
import '../../models/prescription_model.dart';

class MedicationDetailsWidget extends StatelessWidget {
  final PrescriptionByPatientResponse prescription;
  const MedicationDetailsWidget({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
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
        26.gap,
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD1D1D1)),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8ECFD),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        prescription.dispensedDate?.toString() ?? '',
                        style: CustomTextStyle.texttiny11.w700
                            .withColorHex(0xff530186),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8ECFD),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'On due date',
                        style: CustomTextStyle.texttiny11.w700
                            .withColorHex(0xff530186),
                      ),
                    ),
                  ],
                ),
              ),
              _divider,
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${(prescription.pharmacyInventory!.productName?.isEmpty ?? true) ? '-no-name-' : prescription.pharmacyInventory!.productName}',
                            style: CustomTextStyle.textxSmall13.w700
                                .withColorHex(0xff2F2F2F),
                          ),
                          3.gap,
                          Text(
                            '${prescription.quantity ?? ''}, ${prescription.frequency ?? ''}, ${prescription.duration ?? ''}',
                            style: CustomTextStyle.textxSmall13
                                .withColorHex(0xff393939),
                          ),
                          3.gap,
                          Text(
                            prescription.treatment!.carePlan ?? '',
                            style: CustomTextStyle.textxSmall13
                                .withColorHex(0xff393939),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        31.gap,
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  pop(false);
                },
                child: Container(
                  height: 46,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF43E64A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: CustomTextStyle.textsmall14.withColorHex(0xFF181819),
                  ),
                ),
              ),
            ),
            22.gap,
            Expanded(
              child: InkWell(
                onTap: () {
                  pop(true);
                },
                child: Container(
                  height: 46,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF43E64A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Snooze',
                    style: CustomTextStyle.textsmall14.withColorHex(0xFF181819),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget get _divider => const Divider(
        height: 1,
        color: Color(0xffD1D1D1),
      );
}
