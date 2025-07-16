import '../../../../../provider/all_providers.dart';
import '../../../../../utils/packages.dart';

class ImmunizationMedical extends ConsumerStatefulWidget {
  const ImmunizationMedical({super.key});

  @override
  ConsumerState<ImmunizationMedical> createState() =>
      _ImmunizationMedicalState();
}

class _ImmunizationMedicalState extends ConsumerState<ImmunizationMedical> {
  List<bool> showDetailsList = [];

  @override
  Widget build(BuildContext context) {
    final immunizationResponse = ref.watch(userFetchImmunizationProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRecordTile(
                title: 'Immunization',
                icon: SvgAssets.medx,
                isSvg: false,
                isSubtitle: false,
                isCircle: true,
                dropDown: true,
                onTap: () {
                  // pushTo(const ImmunizationMedical());
                },
              ),
              tinySpace(),
              immunizationResponse.when(
                data: (dataz) {
                  if (immunizationResponse.isRefreshing) {
                    return const CircularProgressIndicator();
                  }

                  // Access the treatmentRes field
                  final immunization = dataz;
                  // Check if treatments is null or empty
                  if (immunization.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Text(
                            'No Immunization available.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // Render the ListView if treatments are available
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: immunization.length,
                      itemBuilder: (context, index) {
                        if (showDetailsList.length < immunization.length) {
                          showDetailsList
                              .add(false); // Initially all are collapsed
                        }
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  width: 0.5,
                                  color: const Color(0xffAEAEAE),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showDetailsList[index] = !showDetailsList[
                                              index]; // Toggle the current index
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${immunization[index].vaccine}',
                                              style: CustomTextStyle
                                                  .textsmall14.w700
                                                  .withColorHex(0xff393939),
                                            ),
                                          ),
                                          showDetailsList[index]
                                              ? const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Color(0xffB3B3B3))
                                              : const Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: Color(0xffB3B3B3)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (showDetailsList[index]) ...[
                                    Container(
                                        width: double.infinity,
                                        decoration: const ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.50,
                                                color: Color(0xFFCACACA)),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              topRight: Radius.circular(7),
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              // width: 350,
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 231,
                                                    child: Text(
                                                      'Age:',
                                                      style: CustomTextStyle
                                                          .textsmall14.w700
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                  10.gap,
                                                  Expanded(
                                                    flex: 91,
                                                    child: Text(
                                                      '${immunization[index].age}',
                                                      style: CustomTextStyle
                                                          .textsmall14.w500
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              // width: 350,
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 231,
                                                    child: Text(
                                                      'Batch Number:',
                                                      style: CustomTextStyle
                                                          .textsmall14.w700
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                  10.gap,
                                                  Expanded(
                                                    flex: 91,
                                                    child: Text(
                                                      '${immunization[index].batchId}',
                                                      style: CustomTextStyle
                                                          .textsmall14.w500
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              // width: 350,
                                              padding: const EdgeInsets.all(16),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 231,
                                                    child: Text(
                                                      'Brand:',
                                                      style: CustomTextStyle
                                                          .textsmall14.w700
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                  10.gap,
                                                  Expanded(
                                                    flex: 91,
                                                    child: Text(
                                                      '${immunization[index].vaccineBrand}',
                                                      style: CustomTextStyle
                                                          .textsmall14.w500
                                                          .withColorHex(
                                                              0xff393939),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: formatNewDate(
                                                        immunization[index]
                                                            .dateGiven!),
                                                    style: const TextStyle(
                                                      color: Color(0xFF797979),
                                                      fontSize: 13,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      });
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Failed to load treatments.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              mediumSpace(),
            ],
          ),
        ],
      ),
    );
  }
}
