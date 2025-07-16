import 'package:collection/collection.dart';
import '../../../provider/all_providers.dart';
import '../../../provider/index_provider.dart';
import '../../../utils/packages.dart';
import '../providers/prescription_provider.dart';
import 'widgets/prescriotions_schedule_box.dart';

class PrescriptionPage extends ConsumerWidget {
  final bool showBackButton;

  const PrescriptionPage({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final allPrescriptoonState = ref.watch(userAllPrescriptionProvider);
    final prescriptionsAsync = ref.watch(userPrescriptionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            if (showBackButton)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryLightColor, // Light green color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.keyboard_arrow_left_rounded,
                      color: Colors.white),
                ),
              ),
            smallHorSpace(),
            const Text(
              'Prescriptions',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          ref.read(presctiptionProvider.notifier).refreshData();
        },
        child: prescriptionsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error loading prescriptions:'),
          ),
          data: (prescriptionModel) {
            // final prescriptions =  prescriptionModel.data ?? [];

            final prescriptions =
                prescriptionModel; // ✅ Assuming prescriptionModel is a List<Prescription>

            // Ensure `prescriptions` is not null before calling `groupListsBy`
            final groupedByTreatment = prescriptions.groupListsBy(
              (prescription) => prescription.treatment!.id,
            );
            final groupedByDate = prescriptions.groupListsBy(
              (prescription) => prescription.queuedInDate,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27)
                        .copyWith(bottom: 0),
                    child: Column(
                      children: [
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
                                          // '${(i.medication?.isEmpty ?? true) ? '-no-name-' : i.medication} | ${i.quantity ?? ''}, ${i.frequency ?? ''}, ${i.duration ?? ''}',
                                          (i.pharmacyInventory?.productName
                                                      ?.isEmpty ??
                                                  true)
                                              ? '-no-name-'
                                              : '${i.pharmacyInventory!.productName!} | ${i.quantity ?? ''}mg, | ${i.frequency ?? ''} times per day, ${i.duration ?? ""} day(s)',

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
                    itemCount: groupedByTreatment.length,
                    separatorBuilder: (context, index) => 0.gap,
                    itemBuilder: (context, index) {
                      final item = groupedByTreatment.entries.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.all(27)
                            .copyWith(top: 12, bottom: 0),
                        child: PrescriptionScheduleBox(
                          prescriptions: item
                              .value, // ✅ No cast needed if already List<PrescriptionByPatientResponse>
                        ),
                      );
                    },
                  ),

                // SliverList.separated(
                //   itemCount: groupedByTreatment?.length ?? 0,
                //   separatorBuilder: (context, index) => 0.gap,
                //   itemBuilder: (context, index) {
                //     final item = groupedByTreatment?.entries.elementAt(index);
                //     if (item != null) {
                //       return Padding(
                //         padding: const EdgeInsets.all(27)
                //             .copyWith(top: 12, bottom: 0),
                //         child: PrescriptionScheduleBox(
                //           prescriptions: item.value
                //               .cast<Prescription>(), // ✅ Fix applied here
                //         ),
                //       );
                //     } else {
                //       return SizedBox.shrink();
                //     }
                //   },
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
