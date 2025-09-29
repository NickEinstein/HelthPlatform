import '../../../../../provider/all_providers.dart';
import '../../../../../utils/packages.dart';
import '../../../model/health_record_model.dart';

class NotesPage extends ConsumerStatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final MedicalRecordResponse screenData;
  const NotesPage({super.key, required this.screenData});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  bool showDetails = false;
  bool showDetails2 = false;
  bool showDetails3 = false;
  bool showDetails4 = false;
  bool showDetails5 = false;
  bool showDetails6 = false;

  @override
  Widget build(BuildContext context) {
    final prescriptionResponse =
        ref.watch(userPrescriptionByIdProvider(widget.screenData.id!));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Health Record',
        allowBackButton: false,
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(context, 0.15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xff444444),
                        ),
                      ),
                    ],
                  ),
                  smallSpace(),
                  buildRecordTile(
                    title: widget.screenData.diagnosis ?? '',
                    subtitle: formatNewDate(
                        widget.screenData.dateOfVisit.toIso8601String() ?? ''),
                    icon: SvgAssets.medx,
                    isSvg: false,
                    isCircle: true,
                    dropDown: true,
                    onTap: () {
                      // pushTo(const ImmunizationMedical());
                    },
                  ),
                  tinySpace(),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xffF5F5F5),
                  //     borderRadius: BorderRadius.circular(7),
                  //     border: Border.all(
                  //       width: 0.5,
                  //       color: const Color(0xffAEAEAE),
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 16,
                  //           vertical: 12,
                  //         ),
                  //         child: InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               showDetails = !showDetails;
                  //             });
                  //           },
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                 child: Text(
                  //                   'Vitals',
                  //                   style: CustomTextStyle.textsmall14.w700
                  //                       .withColorHex(0xff393939),
                  //                 ),
                  //               ),
                  //               showDetails
                  //                   ? const Icon(
                  //                       Icons.keyboard_arrow_down_rounded,
                  //                       color: Color(0xffB3B3B3))
                  //                   : const Icon(
                  //                       Icons.keyboard_arrow_right_rounded,
                  //                       color: Color(0xffB3B3B3)),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       // if (showDetails) ...[
                  //       //   Container(
                  //       //       width: double.infinity,
                  //       //       decoration: const ShapeDecoration(
                  //       //         color: Colors.white,
                  //       //         shape: RoundedRectangleBorder(
                  //       //           side: BorderSide(
                  //       //               width: 0.50, color: Color(0xFFCACACA)),
                  //       //           borderRadius: BorderRadius.only(
                  //       //             topLeft: Radius.circular(7),
                  //       //             topRight: Radius.circular(7),
                  //       //           ),
                  //       //         ),
                  //       //       ),
                  //       //       padding: const EdgeInsets.all(16),
                  //       //       child: widget.screenData.vitals?.isEmpty ?? true
                  //       //           ? Center(
                  //       //               child: Text(
                  //       //                 'No vitals data available.',
                  //       //                 style: CustomTextStyle.textsmall14
                  //       //                     .withColorHex(0xff888888),
                  //       //               ),
                  //       //             )
                  //       //           : ListView.builder(
                  //       //               shrinkWrap: true,
                  //       //               physics:
                  //       //                   const NeverScrollableScrollPhysics(), // Prevent scrolling if nested in another scrollable widget
                  //       //               itemCount:
                  //       //                   widget.screenData.vitals?.length ?? 0,
                  //       //               padding: const EdgeInsets.all(0),
                  //       //               itemBuilder: (context, index) {
                  //       //                 final vital =
                  //       //                     widget.screenData.vitals![index];

                  //       //                 return Column(
                  //       //                   crossAxisAlignment: CrossAxisAlignment
                  //       //                       .start, // Ensure alignment starts from the left
                  //       //                   children: [
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text: 'Blood Pressure: ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text:
                  //       //                                 '${vital.bloodPressure} mmHg',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text:
                  //       //                                 'Heart Rate (Pulse): ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text:
                  //       //                                 '${vital.heartPulse} beats per minute (bpm)',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text: 'Respiratory Rate: ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text:
                  //       //                                 '${vital.respiratory} breaths per minute',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text: 'Body Temperature: ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text:
                  //       //                                 '${vital.temperature}°F (37°C)',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text: 'Height: ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text: '${vital.height} cm',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text.rich(
                  //       //                       TextSpan(
                  //       //                         children: [
                  //       //                           TextSpan(
                  //       //                             text: 'Weight: ',
                  //       //                             style: CustomTextStyle
                  //       //                                 .labelMedium
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                           TextSpan(
                  //       //                             text: '${vital.weight} kg',
                  //       //                             style: CustomTextStyle
                  //       //                                 .textsmall14
                  //       //                                 .withColorHex(
                  //       //                                     0xff393939),
                  //       //                           ),
                  //       //                         ],
                  //       //                       ),
                  //       //                     ),
                  //       //                     smallSpace(),
                  //       //                     Text(
                  //       //                       'Additional Notes:',
                  //       //                       style: CustomTextStyle.labelMedium
                  //       //                           .withColorHex(0xff393939),
                  //       //                     ),
                  //       //                     tiny5Space(),
                  //       //                     vital.notes?.isEmpty ?? true
                  //       //                         ? Center(
                  //       //                             child: Text(
                  //       //                               'No notes available.',
                  //       //                               style: CustomTextStyle
                  //       //                                   .textsmall14
                  //       //                                   .withColorHex(
                  //       //                                       0xff888888),
                  //       //                             ),
                  //       //                           )
                  //       //                         : ListView.builder(
                  //       //                             shrinkWrap: true,
                  //       //                             physics:
                  //       //                                 const NeverScrollableScrollPhysics(), // Prevent scrolling if nested
                  //       //                             itemCount: vital
                  //       //                                     .notes?.length ??
                  //       //                                 0, // Dynamically handles the size of the list
                  //       //                             padding:
                  //       //                                 const EdgeInsets.all(0),
                  //       //                             itemBuilder:
                  //       //                                 (context, index) {
                  //       //                               final notes = vital
                  //       //                                       .notes![
                  //       //                                   index]; // Access the current percentage

                  //       //                               return Padding(
                  //       //                                 padding: const EdgeInsets
                  //       //                                     .symmetric(
                  //       //                                     vertical:
                  //       //                                         4.0), // Add spacing between items
                  //       //                                 child: Text(
                  //       //                                   '- ${notes.note}',
                  //       //                                   style: CustomTextStyle
                  //       //                                       .textsmall14
                  //       //                                       .withColorHex(
                  //       //                                           0xff393939),
                  //       //                                 ),
                  //       //                               );
                  //       //                             },
                  //       //                           ),
                  //       //                   ],
                  //       //                 );
                  //       //               })),

                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //             horizontal: 16,
                  //             vertical: 12,
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                 child: Text.rich(
                  //                   TextSpan(
                  //                     children: [
                  //                       TextSpan(
                  //                         text:
                  //                             ' ${formatNewDate(widget.screenData.dateOfVisit ?? '')}',
                  //                         style: const TextStyle(
                  //                           color: Color(0xFF797979),
                  //                           fontSize: 13,
                  //                           fontFamily: 'Inter',
                  //                           fontWeight: FontWeight.w400,
                  //                           height: 0,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ],
                  //   ),
                  // ),
                  // tinySpace(),
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
                                showDetails2 = !showDetails2;
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Diagnosis & Treament',
                                    style: CustomTextStyle.textsmall14.w700
                                        .withColorHex(0xff393939),
                                  ),
                                ),
                                showDetails2
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xffB3B3B3))
                                    : const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Color(0xffB3B3B3)),
                              ],
                            ),
                          ),
                        ),
                        if (showDetails2) ...[
                          Container(
                            width: double.infinity,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCACACA)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: widget.screenData.diagnosis!.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No diagnosis',
                                        style: CustomTextStyle.textsmall14
                                            .withColorHex(0xff393939),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Ensure alignment starts from the left
                                    children: [
                                      smallSpace(),
                                      Text(
                                        'Diagnosis:',
                                        style: CustomTextStyle.labelMedium
                                            .withColorHex(0xff393939),
                                      ),
                                      tiny5Space(),
                                      Text(
                                        '${widget.screenData.diagnosis}',
                                        style: CustomTextStyle.textsmall14
                                            .withColorHex(0xff393939),
                                      ),
                                      smallSpace(),
                                      Text(
                                        'Treatment:',
                                        style: CustomTextStyle.labelMedium
                                            .withColorHex(0xff393939),
                                      ),
                                      tiny5Space(),
                                      // Text(
                                      //   '${widget.screenData.medication}',
                                      //   style: CustomTextStyle.textsmall14
                                      //       .withColorHex(0xff393939),
                                      // ),
                                      smallSpace(),
                                      // Text(
                                      //   'Other Treatment:',
                                      //   style: CustomTextStyle.labelMedium
                                      //       .withColorHex(0xff393939),
                                      // ),
                                      // tiny5Space(),
                                      // Text(
                                      //   '${widget.screenData.otherMedication}',
                                      //   style: CustomTextStyle.textsmall14
                                      //       .withColorHex(0xff393939),
                                      // ),
                                      smallSpace(),
                                      // Text(
                                      //   'Treatment:',
                                      //   style: CustomTextStyle.labelMedium
                                      //       .withColorHex(0xff393939),
                                      // ),
                                      // tiny5Space(),
                                      // Text(
                                      //   '${widget.screenData.diagnosis}',
                                      //   style: CustomTextStyle.textsmall14
                                      //       .withColorHex(0xff393939),
                                      // ),
                                    ],
                                  ),
                          ),
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
                                        const TextSpan(
                                          text: 'Assigned Doctor: ',
                                          style: TextStyle(
                                            color: Color(0xFF797979),
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${widget.screenData.doctor} ',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
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
                  tinySpace(),
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
                                showDetails6 = !showDetails6;
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Prescription',
                                    style: CustomTextStyle.textsmall14.w700
                                        .withColorHex(0xff393939),
                                  ),
                                ),
                                showDetails6
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xffB3B3B3))
                                    : const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Color(0xffB3B3B3)),
                              ],
                            ),
                          ),
                        ),
                        if (showDetails6) ...[
                          Container(
                            width: double.infinity,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCACACA)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tiny5Space(),
                                prescriptionResponse.when(
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (error, _) => Center(
                                      child: Text('No available prescription')),
                                  data: (prescriptions) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (prescriptions.isNotEmpty)
                                          ...prescriptions
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            final prescription = entry.value;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                '${index + 1}. ${prescription.medication ?? ''} ${prescription.duration} to be taken ${prescription.frequency}',
                                                style: CustomTextStyle
                                                    .textsmall14
                                                    .withColorHex(0xff393939),
                                              ),
                                            );
                                          }).toList(),
                                        if (prescriptions.isNotEmpty) ...[
                                          smallSpace(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            child: Center(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xFFCACACA),
                                                      width: 1), // Grey outline
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    context.push(
                                                        Routes.PRESCRIPTION,
                                                        extra: true);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff8209CD),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                    child: Text(
                                                      'View Prescription Details',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  tinySpace(),
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
                                showDetails3 = !showDetails3;
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Care plan',
                                    style: CustomTextStyle.textsmall14.w700
                                        .withColorHex(0xff393939),
                                  ),
                                ),
                                showDetails3
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xffB3B3B3))
                                    : const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Color(0xffB3B3B3)),
                              ],
                            ),
                          ),
                        ),
                        if (showDetails3) ...[
                          Container(
                            width: double.infinity,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCACACA)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: widget.screenData.carePlan!.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No Care plan',
                                        style: CustomTextStyle.textsmall14
                                            .withColorHex(0xff393939),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Ensure alignment starts from the left
                                    children: [
                                      smallSpace(),
                                      Text(
                                        'Care Plan:',
                                        style: CustomTextStyle.labelMedium
                                            .withColorHex(0xff393939),
                                      ),
                                      tiny5Space(),
                                      Text(
                                        '${widget.screenData.carePlan}',
                                        style: CustomTextStyle.textsmall14
                                            .withColorHex(0xff393939),
                                      ),
                                      smallSpace(),
                                    ],
                                  ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  tinySpace(),
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
                                showDetails5 = !showDetails5;
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Discharge Note',
                                    style: CustomTextStyle.textsmall14.w700
                                        .withColorHex(0xff393939),
                                  ),
                                ),
                                showDetails5
                                    ? const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xffB3B3B3))
                                    : const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Color(0xffB3B3B3)),
                              ],
                            ),
                          ),
                        ),
                        if (showDetails5) ...[
                          Container(
                            width: double.infinity,
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFCACACA)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Ensure alignment starts from the left
                              children: [
                                // tiny5Space(),

                                // widget.screenData.doctorNote!.isEmpty
                                //     ? Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Text(
                                //             'No discharge note',
                                //             style: CustomTextStyle.textsmall14
                                //                 .withColorHex(0xff393939),
                                //           ),
                                //         ],
                                //       )
                                //     :
                                //      Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             vertical:
                                //                 4.0), // Add spacing between items
                                //         child: Text(
                                //           '${widget.screenData.doctorNote}',
                                //           style: CustomTextStyle.textsmall14
                                //               .withColorHex(0xff393939),
                                //         ),
                                //       ),
                                // smallSpace(),
                                // Text(
                                //   'Treatment:',
                                //   style: CustomTextStyle.labelMedium
                                //       .withColorHex(0xff393939),
                                // ),
                                // tiny5Space(),
                                // Text(
                                //   '${widget.screenData.diagnosis}',
                                //   style: CustomTextStyle.textsmall14
                                //       .withColorHex(0xff393939),
                                // ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  mediumSpace(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
