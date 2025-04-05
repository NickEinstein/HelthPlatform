import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../constants/constants.dart';
import '../../../resources/resources.dart';
import '../../../resources/textstyles/app_textstyles.dart';
import '../../../routes/old_routes.dart';
import '../../../utils/app_input/app_input.dart';
import '../../../utils/custom_header.dart';
import '../../../utils/dialogs/dialog.dart';
import '../../../utils/extensions/primary_button.dart';
import 'widgets/send_message_confirmation.dart';

class ContactPharmarcyPage extends ConsumerWidget {
  const ContactPharmarcyPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      // appBar: const CustomAppBar(
      //   title: 'Pharmarcy',
      // ),
      // drawer: const HomeDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(27).copyWith(bottom: 0),
        children: [
          verticalSpace(context, 0.08),
          CustomHeader(
            title: 'Pharmarcy',
            onPressed: () {
              Navigator.pop(context);
            },
            // onSearchPressed: () {
            //   context.push(Routes.SEARCHCOMMUNITY);
            // },
          ),
          smallSpace(),
          InkWell(
            onTap: () {
              pop();
            },
            child: Row(
              children: [
                SvgPicture.asset(SvgAssets.arrowBack),
                11.gap,
                Text(
                  'Prescription Reminders',
                  style: CustomTextStyle.textsmall15.w500,
                )
              ],
            ),
          ),
          18.gap,
          Container(
            decoration: ShapeDecoration(
              color: const Color(0xFFFFF2F1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgAssets.prescriptionPill,
                ),
                26.gap,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Pharmarcy',
                        style: CustomTextStyle.textsmall15.w700
                            .withColorHex(0xff343333),
                      ),
                      5.gap,
                      Text(
                        'Get connected with us',
                        style: CustomTextStyle.textxSmall13
                            .withColorHex(0xff909090),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Color(0xffFF6159),
                ),
              ],
            ),
          ),
          29.gap,
          Text(
            'Title:',
            style: CustomTextStyle.textsmall14.withColorHex(0xFF444444),
          ),
          8.gap,
          const AppInput(
            fillColor: Color(0xffFBFBFB),
          ),
          18.gap,
          Text(
            'Message:',
            style: CustomTextStyle.textsmall14.withColorHex(0xFF444444),
          ),
          8.gap,
          const AppInput(
            fillColor: Color(0xffFBFBFB),
            maxLines: 10,
          ),
          18.gap,
          AppButton.rounded(
            onPressed: () {
              Dialogs.openBottomSheet(
                child: const SendMessageConfirmationWidget(),
              );
            },
            label: 'Send Message',
          ),
        ],
      ),
    );
  }
}
