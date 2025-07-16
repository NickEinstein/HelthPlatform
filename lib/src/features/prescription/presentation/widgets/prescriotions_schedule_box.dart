import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/prescription/models/prescription_model.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';

import '../../../../resources/textstyles/app_textstyles.dart';
import '../../../../utils/dialogs/dialog.dart';
import 'medication_details_widget.dart';
import 'set_new_time_widget.dart';

class PrescriptionScheduleBox extends ConsumerWidget {
  final List<PrescriptionByPatientResponse> prescriptions;
  const PrescriptionScheduleBox({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final first = prescriptions.firstOrNull;

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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (first?.dispensedDate != null) ...[
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
                          DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(first!.dispensedDate!)),
                          style: CustomTextStyle.texttiny11.w700
                              .withColorHex(0xff2F2F2F),
                        ),
                      ),
                    ],
                  ),
                  10.gap,
                ],
                Text(
                  first?.treatment!.diagnosis ?? '',
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

  Widget _tab(PrescriptionByPatientResponse prescription) {
    return InkWell(
      onTap: () async {
        bool? t = await Dialogs.openBottomSheet(
          child: MedicationDetailsWidget(
            prescription: prescription, // If needed, adapt this widget
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
                    (prescription.pharmacyInventory!.productName?.isEmpty ??
                            true)
                        ? '-no-name-'
                        : prescription.pharmacyInventory!.productName!,
                    style: CustomTextStyle.textxSmall13.w700
                        .withColorHex(0xff2F2F2F),
                  ),
                  3.gap,
                  Text(
                    '${prescription.quantity ?? ''}mg, ${prescription.frequency ?? ''} times per day, ${prescription.duration ?? ''} day(s)',
                    style:
                        CustomTextStyle.textxSmall13.withColorHex(0xff393939),
                  ),
                  3.gap,
                  Text(
                    prescription.treatment!.carePlan ?? '',
                    style:
                        CustomTextStyle.textxSmall13.withColorHex(0xff393939),
                  ),
                ],
              ),
            ),

// Inside your widget build:
            if (prescription.dispensedDate != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffF8ECFD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  DateFormat.Hm()
                      .format(DateTime.parse(prescription.dispensedDate!)),
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
