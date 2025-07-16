// import 'package:greenzone_medical/features/health_record/presentation/widget/personal/contact_details.dart';
// import 'package:greenzone_medical/packages/app_bar/custom_app_bar.dart';
// import 'package:greenzone_medical/packages/packages.dart';

// import '../../../../../packages/drawer/home_drawer.dart';
// import '../health_helper.dart';
// import 'immunization_medical.dart';
// import 'medical_history.dart';

// class AllegiesMedical extends ConsumerStatefulWidget {
//   const AllegiesMedical({super.key});

//   @override
//   ConsumerState<AllegiesMedical> createState() => _AllegiesMedicalState();
// }

// class _AllegiesMedicalState extends ConsumerState<AllegiesMedical> {
//   bool showDetails = false;

//   @override
//   Widget build(BuildContext context) {
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
//                       InkWell(
//                         onTap: () {
//                           // Navigator.pop(context);
//                           pushTo(const MedicalHistory());
//                         },
//                         child: Row(
//                           children: [
//                             Text(
//                               'Medical History',
//                               style: CustomTextStyle.textsmall15.w400
//                                   .withColorHex(0xff343333),
//                             ),
//                             const Icon(
//                               Icons.arrow_forward,
//                               color: Color(0xff444444),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   smallSpace(),
//                   buildRecordTile(
//                     title: 'Allergies',
//                     icon: SvgAssets.medx,
//                     isSvg: false,
//                     isSubtitle: false,
//                     isCircle: true,
//                     dropDown: true,
//                     onTap: () {
//                       // pushTo(const ImmunizationMedical());
//                     },
//                   ),
//                   tinySpace(),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xffF5F5F5),
//                       borderRadius: BorderRadius.circular(7),
//                       border: Border.all(
//                         width: 0.5,
//                         color: const Color(0xffAEAEAE),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 12,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 showDetails = !showDetails;
//                               });
//                             },
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Penicillin and other antibiotics',
//                                     style: CustomTextStyle.textsmall14.w700
//                                         .withColorHex(0xff393939),
//                                   ),
//                                 ),
//                                 showDetails
//                                     ? const Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: Color(0xffB3B3B3))
//                                     : const Icon(
//                                         Icons.keyboard_arrow_right_rounded,
//                                         color: Color(0xffB3B3B3)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         if (showDetails) ...[
//                           Container(
//                             width: double.infinity,
//                             decoration: const ShapeDecoration(
//                               color: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 side: BorderSide(
//                                     width: 0.50, color: Color(0xFFCACACA)),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(7),
//                                   topRight: Radius.circular(7),
//                                 ),
//                               ),
//                             ),
//                             padding: const EdgeInsets.all(16),
//                             child: Text(
//                               'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.',
//                               style: CustomTextStyle.textsmall14
//                                   .withColorHex(0xff393939),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text.rich(
//                                     TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: 'Symptoms:',
//                                           style: TextStyle(
//                                             color: Color(0xFF797979),
//                                             fontSize: 13,
//                                             fontFamily: 'Inter',
//                                             fontWeight: FontWeight.w700,
//                                             height: 0,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: ' Wheezing',
//                                           style: TextStyle(
//                                             color: Color(0xFF797979),
//                                             fontSize: 13,
//                                             fontFamily: 'Inter',
//                                             fontWeight: FontWeight.w400,
//                                             height: 0,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
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
