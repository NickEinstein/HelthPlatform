import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../resources/textstyles/app_textstyles.dart';
import '../../../../utils/dialogs/dialog.dart';
import '../../models/get_prescriptions_model.dart';
import 'medication_details_widget.dart';
import 'set_new_time_widget.dart';

class PrescriptionScheduleBox extends ConsumerWidget {
  final List<Prescription> prescriptions;
  const PrescriptionScheduleBox({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (prescriptions.firstOrNull?.appointDate != null) ...[
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xffEAEAEA),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          prescriptions.firstOrNull?.appointDate?.toString() ??
                              '',
                          style: CustomTextStyle.texttiny11.w700
                              .withColorHex(0xff2F2F2F),
                        ),
                      ),
                    ],
                  ),
                  10.gap,
                ],
                Text(
                  prescriptions.firstOrNull?.diagnosis?.toString() ?? '',
                  style:
                      CustomTextStyle.texttiny11.w700.withColorHex(0xff2F2F2F),
                ),
              ],
            ),
          ),
          _divider,
          for (var prescription in prescriptions) ...[
            _tab(prescription),
            if (prescriptions.last != prescription) _divider,
          ],
        ],
      ),
    );
  }

  Widget _tab(Prescription prescription) {
    return InkWell(
      onTap: () async {
        bool? t = await Dialogs.openBottomSheet(
          child: MedicationDetailsWidget(
            prescription: prescription,
          ),
        );
        if (!(t ?? false)) return;
        Dialogs.openBottomSheet(
          child: SetNewTimeWidget(
            prescription: prescription,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(prescription.medication?.isEmpty ?? true) ? '-no-name-' : prescription.medication}',
                    style: CustomTextStyle.textxSmall13.w700
                        .withColorHex(0xff2F2F2F),
                  ),
                  3.gap,
                  Text(
                    '${prescription.quantity ?? ''}, ${prescription.frequency ?? ''}, ${prescription.duration ?? ''}',
                    style:
                        CustomTextStyle.textxSmall13.withColorHex(0xff393939),
                  ),
                  3.gap,
                  Text(
                    prescription.carePlan ?? '',
                    style:
                        CustomTextStyle.textxSmall13.withColorHex(0xff393939),
                  ),
                ],
              ),
            ),
            if (prescription.appointTime != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffF8ECFD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  prescription.appointTime?.toString() ?? '',
                  style:
                      CustomTextStyle.texttiny11.w700.withColorHex(0xff530186),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget get _divider => const Divider(
      height: 1,
      color: Color(0xffD1D1D1),
    );
