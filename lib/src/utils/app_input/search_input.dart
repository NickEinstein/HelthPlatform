// import 'package:greenzone_medical/packages/packages.dart';

// class SearchInput extends StatefulWidget {
//   final TextEditingController? controller;
//   final void Function(String)? onChanged;
//   final void Function(String)? onSubmitted;
//   final bool? readOnly;
//   final bool? disabled;
//   final bool autofocus;
//   const SearchInput({
//     super.key,
//     this.controller,
//     this.onChanged,
//     this.onSubmitted,
//     this.readOnly,
//     this.disabled,
//     this.autofocus = false,
//   });

//   @override
//   State<SearchInput> createState() => _SearchInputState();
// }

// class _SearchInputState extends State<SearchInput> {
//   bool hasInput = false;
//   final _onNullcontroller = TextEditingController();

//   get controller => widget.controller ?? _onNullcontroller;

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       if (controller.text.isEmpty && hasInput) {
//         setState(() {
//           hasInput = false;
//         });
//       } else if (!hasInput && controller.text.isNotEmpty) {
//         setState(() {
//           hasInput = true;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: TextFormField(
//         onChanged: widget.onChanged,
//         onFieldSubmitted: widget.onSubmitted,
//         readOnly: widget.readOnly ?? false,
//         enabled: !(widget.disabled ?? false),
//         autofocus: widget.autofocus,
//         decoration: InputDecoration(
//           hintText: 'Search',
//           fillColor: AppColors.baseBackgroundLight,
//           filled: true,
//           hintStyle: CustomTextStyle.paragraphMedium
//               .withColor(AppColors.greyQuatinary),
//           suffixIcon: hasInput
//               ? InkWell(
//                   onTap: () {
//                     controller.clear();
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: SvgPicture.asset(
//                       IconsaxBulk.closeCircle,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: SvgPicture.asset(
//                     HomeIcons.productsInactive,
//                   ),
//                 ),
//           border: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//         ),
//         controller: controller,
//       ),
//     );
//   }
// }
