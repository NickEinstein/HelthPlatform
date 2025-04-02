import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenzone_medical/src/provider/all_providers.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../constants/constants.dart';
import '../../../provider/index_provider.dart';
import '../../../resources/resources.dart';
import '../../../resources/textstyles/app_textstyles.dart';
import '../../../utils/custom_header.dart';
import '../models/get_prescriptions_model.dart';
import '../providers/prescription_provider.dart';
import 'widgets/prescriotions_schedule_box.dart';
import 'package:collection/collection.dart';

class PrescriptionPage extends ConsumerWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPrescriptoonState = ref.watch(allPrescriptionsListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.read(presctiptionProvider.notifier).refreshData();
        },
        child: allPrescriptoonState.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error loading prescriptions: $error'),
          ),
          data: (prescriptionModel) {
            // final prescriptions =  prescriptionModel.data ?? [];
            final prescriptions = prescriptionModel
                .expand(
                    (model) => model.data ?? []) // Extract data from each model
                .toList();

            // Ensure `prescriptions` is not null before calling `groupListsBy`
            final groupedByTreatment = prescriptions.groupListsBy(
              (prescription) => prescription.treatmentId,
            );
            final groupedByDate = prescriptions.groupListsBy(
              (prescription) => prescription.appointDate,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(27).copyWith(bottom: 0),
                    child: Column(
                      children: [
                        verticalSpace(context, 0.05),
                        InkWell(
                          onTap: () {
                            ref.read(indexProvider.notifier).state = 0;
                          },
                          child: Row(
                            children: [
                              Text(
                                'Prescription Reminders',
                                style: CustomTextStyle.textsmall15.w500,
                              ),
                            ],
                          ),
                        ),
                        18.gap,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(19),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(1.00, 0.00),
                              end: Alignment(-1, 0),
                              colors: [Color(0xFF009005), Color(0xFF30CA36)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(SvgAssets.prescriptionIcon),
                              26.gap,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Medication',
                                      style: CustomTextStyle
                                          .textsmall15.w700.white,
                                    ),
                                    if (groupedByDate.isNotEmpty) ...[
                                      for (var i in groupedByDate
                                              .entries.firstOrNull?.value ??
                                          []) ...[
                                        4.gap,
                                        Text(
                                          '${(i.medication?.isEmpty ?? true) ? '-no-name-' : i.medication} | ${i.quantity ?? ''}, ${i.frequency ?? ''}, ${i.duration ?? ''}',
                                          style:
                                              CustomTextStyle.textsmall14.white,
                                        ),
                                      ],
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        46.gap,
                        Text(
                          'Prescriptions',
                          style: CustomTextStyle.textsmall15.w700
                              .withColorHex(0xff444444),
                        ).alignLeft,
                      ],
                    ),
                  ),
                ),
                if (groupedByTreatment.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No prescriptions found."),
                    ),
                  )
                else
                  SliverList.separated(
                    itemCount: groupedByTreatment?.length ?? 0,
                    separatorBuilder: (context, index) => 0.gap,
                    itemBuilder: (context, index) {
                      final item = groupedByTreatment?.entries.elementAt(index);
                      if (item != null) {
                        return Padding(
                          padding: const EdgeInsets.all(27)
                              .copyWith(top: 12, bottom: 0),
                          child: PrescriptionScheduleBox(
                            prescriptions: item.value
                                .cast<Prescription>(), // ✅ Fix applied here
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
