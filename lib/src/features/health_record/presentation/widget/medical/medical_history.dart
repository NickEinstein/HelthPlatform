// import 'package:flutter/scheduler.dart';
// import 'package:greenzone_medical/packages/app_bar/custom_app_bar.dart';
// import 'package:greenzone_medical/packages/packages.dart';

// import '../../../../../packages/drawer/home_drawer.dart';
// import '../../../model/treatment_response.dart';
// import '../../../provider/health_controller.dart';
// import '../../repositories/health_data_repository.dart';
// import '../health_helper.dart';

// class MedicalHistory extends ConsumerStatefulWidget {
//   const MedicalHistory({super.key});

//   @override
//   ConsumerState<MedicalHistory> createState() => _MedicalHistoryState();
// }

// class _MedicalHistoryState extends ConsumerState<MedicalHistory> {
//   List<bool> showDetailsList = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       ref.read(healthControllerProvider.notifier).getTreatment();
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AsyncValue<TreatmentResponseLists> treatmentResponse =
//         ref.watch(getTreatmentUserProvider);

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: const CustomAppBar(
//         title: 'Health Record',
//         allowBackButton: false,
//       ),
//       drawer: const HomeDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             verticalSpace(context, 0.15),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 27),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Color(0xff444444),
//                         ),
//                       ),
//                     ],
//                   ),
//                   smallSpace(),
//                   buildRecordTile(
//                     title: 'Medical History',
//                     icon: SvgAssets.medx,
//                     isSvg: false,
//                     isSubtitle: false,
//                     isCircle: true,
//                     dropDown: true,
//                     onTap: () {},
//                   ),
//                   tinySpace(),
//                   treatmentResponse.when(
//                     data: (dataz) {
//                       if (treatmentResponse.isRefreshing) {
//                         return const CircularProgressIndicator();
//                       }

//                       // Access the treatmentRes field
//                       final treatments = dataz.treatmentRes;
//                       // Check if treatments is null or empty
//                       if (treatments == null || treatments.isEmpty) {
//                         return const Center(
//                           child: Text(
//                             'No treatments available.',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         );
//                       }

//                       // Render the ListView if treatments are available
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         physics: const ScrollPhysics(),
//                         itemCount: treatments.length,
//                         itemBuilder: (context, index) {
//                           final treatment = treatments[index];

//                           // Initialize the showDetailsList for new items
//                           if (showDetailsList.length < treatments.length) {
//                             showDetailsList
//                                 .add(false); // Initially all are collapsed
//                           }

//                           return Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffF5F5F5),
//                                   borderRadius: BorderRadius.circular(7),
//                                   border: Border.all(
//                                     width: 0.5,
//                                     color: const Color(0xffAEAEAE),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 16,
//                                         vertical: 12,
//                                       ),
//                                       child: InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             showDetailsList[index] =
//                                                 !showDetailsList[
//                                                     index]; // Toggle the current index
//                                           });
//                                         },
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 '${treatment.diagnosis}',
//                                                 style: CustomTextStyle
//                                                     .textsmall14.w700
//                                                     .withColorHex(0xff393939),
//                                               ),
//                                             ),
//                                             showDetailsList[index]
//                                                 ? const Icon(
//                                                     Icons
//                                                         .keyboard_arrow_down_rounded,
//                                                     color: Color(0xffB3B3B3),
//                                                   )
//                                                 : const Icon(
//                                                     Icons
//                                                         .keyboard_arrow_right_rounded,
//                                                     color: Color(0xffB3B3B3),
//                                                   ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     if (showDetailsList[index]) ...[
//                                       Container(
//                                         width: double.infinity,
//                                         decoration: const ShapeDecoration(
//                                           color: Colors.white,
//                                           shape: RoundedRectangleBorder(
//                                             side: BorderSide(
//                                                 width: 0.50,
//                                                 color: Color(0xFFCACACA)),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(7),
//                                               topRight: Radius.circular(7),
//                                             ),
//                                           ),
//                                         ),
//                                         padding: const EdgeInsets.all(16),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text.rich(
//                                               TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text: 'Age: ',
//                                                     style: CustomTextStyle
//                                                         .labelMedium
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                   TextSpan(
//                                                     text: '${treatment.age}',
//                                                     style: CustomTextStyle
//                                                         .textsmall14
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             smallSpace(),
//                                             Text.rich(
//                                               TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text: 'Care Plan: ',
//                                                     style: CustomTextStyle
//                                                         .labelMedium
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                   TextSpan(
//                                                     text:
//                                                         '${treatment.carePlan}',
//                                                     style: CustomTextStyle
//                                                         .textsmall14
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             smallSpace(),
//                                             Text.rich(
//                                               TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                     text: 'Treatment Status: ',
//                                                     style: CustomTextStyle
//                                                         .labelMedium
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                   TextSpan(
//                                                     text: treatment
//                                                                 .treatmentStatus ==
//                                                             0
//                                                         ? 'Ongoing'
//                                                         : 'Completed',
//                                                     style: CustomTextStyle
//                                                         .textsmall14
//                                                         .withColorHex(
//                                                             0xff393939),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             smallSpace(),
//                                             Text(
//                                               'Additional Note:',
//                                               style: CustomTextStyle.labelMedium
//                                                   .withColorHex(0xff393939),
//                                             ),
//                                             tiny5Space(),
//                                             Text(
//                                               treatment.additonalNote ?? '',
//                                               style: CustomTextStyle.textsmall14
//                                                   .withColorHex(0xff393939),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 12),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text.rich(
//                                                 TextSpan(
//                                                   children: [
//                                                     TextSpan(
//                                                       text: formatNewDate(
//                                                           treatment
//                                                               .dateOfVisit!),
//                                                       style: const TextStyle(
//                                                         color:
//                                                             Color(0xFF797979),
//                                                         fontSize: 13,
//                                                         fontFamily: 'Inter',
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         height: 0,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const Divider(),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 12),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text.rich(
//                                                 TextSpan(
//                                                   children: [
//                                                     TextSpan(
//                                                       text: treatment.doctor!,
//                                                       style: const TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 13,
//                                                         fontFamily: 'Inter',
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         height: 0,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                               smallSpace(),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     error: (error, stackTrace) {
//                       return const Center(
//                         child: Text(
//                           'Failed to load treatments.',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.red,
//                           ),
//                         ),
//                       );
//                     },
//                     loading: () {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     },
//                   ),
//                   largeSpace(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
