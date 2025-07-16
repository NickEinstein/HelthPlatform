
// import '../../../utils/packages.dart';

// class HealthRecordPage extends ConsumerStatefulWidget {
//   const HealthRecordPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _HealthRecordPageState();
// }

// class _HealthRecordPageState extends ConsumerState<HealthRecordPage> {
//   @override
//   Widget build(BuildContext context) {
//     final user = ref.watch(userProvider);

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
//             // Header Section
//             Column(
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   clipBehavior:
//                       Clip.none, // Prevent clipping of Positioned widgets
//                   children: [
//                     // The SVG Asset
//                     profileImage(user.user?.data?.pictureUrl),

//                     // Positioned Container
//                     Positioned(
//                       bottom: -80, // Adjust to move the container below the SVG
//                       child: Container(
//                         width: 200, // Adjust width as needed
//                         height: 180, // Adjust height as needed
//                         alignment: Alignment.center,
//                         decoration: const BoxDecoration(
//                           color: Colors.transparent,
//                         ),
//                         child: Container(
//                           width:
//                               90, // Slightly larger width for better visibility
//                           height: 90, // Ensure enough height
//                           decoration: const ShapeDecoration(
//                             color: Color(0xFFD9D9D9),
//                             shape: OvalBorder(),
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(ImageAssets.person),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//                 Text(
//                   '${user.user?.data?.firstName ?? ''} ${user.user?.data?.lastName ?? ''}',
//                   style: CustomTextStyle.textxLarge20.w700,
//                 ),
//                 tiny5Space(),
//                 InkWell(
//                   onTap: () {
//                     pushTo(const MainHealthRecord());
//                   },
//                   child: Text(
//                     'Proceed >',
//                     style: CustomTextStyle.textsmall14.w400,
//                   ),
//                 ),
//               ],
//             ),

//             // Content Section
//             // const SizedBox(height: 48),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 27),
//             //   child: Column(
//             //     children: [
//             //       Row(
//             //         children: [
//             //           Text(
//             //             'Dependants',
//             //             style: CustomTextStyle.textsmall14.w400,
//             //           ),
//             //         ],
//             //       ),
//             //       smallSpace(),
//             //       InkWell(
//             //         onTap: () {
//             //           // pushTo(const ContactPharmarcyPage());
//             //         },
//             //         child: Container(
//             //           decoration: ShapeDecoration(
//             //             color: const Color(0xffE9ECFF),
//             //             shape: RoundedRectangleBorder(
//             //               borderRadius: BorderRadius.circular(7),
//             //             ),
//             //           ),
//             //           padding: const EdgeInsets.all(10),
//             //           child: Row(
//             //             children: [
//             //               Container(
//             //                 width:
//             //                     56, // Slightly larger width for better visibility
//             //                 height: 60, // Ensure enough height
//             //                 decoration: const ShapeDecoration(
//             //                   color: Color(0xFFD9D9D9),
//             //                   shape: OvalBorder(),
//             //                   image: DecorationImage(
//             //                     fit: BoxFit.cover,
//             //                     image: AssetImage(ImageAssets.person),
//             //                   ),
//             //                 ),
//             //               ),
//             //               26.gap,
//             //               Expanded(
//             //                 child: Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start,
//             //                   mainAxisAlignment: MainAxisAlignment.center,
//             //                   children: [
//             //                     Text(
//             //                       'Fiona Williams',
//             //                       style: CustomTextStyle.textsmall15.w700
//             //                           .withColorHex(0xff343333),
//             //                     ),
//             //                     5.gap,
//             //                     Text(
//             //                       'Daughter',
//             //                       style: CustomTextStyle.textxSmall13
//             //                           .withColorHex(0xff909090),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ),
//             //               const Icon(
//             //                 Icons.keyboard_arrow_right_outlined,
//             //                 color: Color(0xff3C4BAC),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //       smallSpace(),
//             //       InkWell(
//             //         onTap: () {
//             //           // pushTo(const ContactPharmarcyPage());
//             //         },
//             //         child: Container(
//             //           decoration: ShapeDecoration(
//             //             color: const Color(0xffE9ECFF),
//             //             shape: RoundedRectangleBorder(
//             //               borderRadius: BorderRadius.circular(7),
//             //             ),
//             //           ),
//             //           padding: const EdgeInsets.all(10),
//             //           child: Row(
//             //             children: [
//             //               Container(
//             //                 width:
//             //                     56, // Slightly larger width for better visibility
//             //                 height: 60, // Ensure enough height
//             //                 decoration: const ShapeDecoration(
//             //                   color: Color(0xFFD9D9D9),
//             //                   shape: OvalBorder(),
//             //                   image: DecorationImage(
//             //                     fit: BoxFit.cover,
//             //                     image: AssetImage(ImageAssets.person),
//             //                   ),
//             //                 ),
//             //               ),
//             //               26.gap,
//             //               Expanded(
//             //                 child: Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start,
//             //                   mainAxisAlignment: MainAxisAlignment.center,
//             //                   children: [
//             //                     Text(
//             //                       'Doug Williams',
//             //                       style: CustomTextStyle.textsmall15.w700
//             //                           .withColorHex(0xff343333),
//             //                     ),
//             //                     5.gap,
//             //                     Text(
//             //                       'Son',
//             //                       style: CustomTextStyle.textxSmall13
//             //                           .withColorHex(0xff909090),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               ),
//             //               const Icon(
//             //                 Icons.keyboard_arrow_right_outlined,
//             //                 color: Color(0xff3C4BAC),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget profileImage(String? pictureUrl) {
//     if (pictureUrl != null && pictureUrl.isNotEmpty) {
//       return Image.network(
//         pictureUrl,
//         height: 60,
//         width: 40,
//         fit: BoxFit.cover,
//         errorBuilder:
//             (BuildContext context, Object error, StackTrace? stackTrace) {
//           return SvgPicture.asset(
//             SvgAssets.medCurve,
//             width: MediaQuery.sizeOf(context).width,
//             fit: BoxFit.cover,
//           );
//         },
//       );
//     } else {
//       // Fallback for null or empty pictureUrl
//       return SvgPicture.asset(
//         SvgAssets.medCurve,
//         width: MediaQuery.sizeOf(context).width,
//         fit: BoxFit.cover,
//       );
//     }
//   }
// }
