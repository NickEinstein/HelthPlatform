import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../../../resources/resources.dart';
import '../../../../resources/textstyles/app_textstyles.dart';
import '../../../../utils/extensions/primary_button.dart';

class SendMessageConfirmationWidget extends StatelessWidget {
  const SendMessageConfirmationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          SvgAssets.clap,
        ),
        23.gap,
        Text(
          'Hello \$Firstname',
          style: CustomTextStyle.textsmall14.w700.withColorHex(0xFF444444),
        ),
        25.gap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Your message has been sent to your pharmacy.\nI’m sure they’ll get back to you soon.',
            style: CustomTextStyle.textsmall14.withColorHex(0xFF444444),
            textAlign: TextAlign.center,
          ),
        ),
        29.gap,
        AppButton.rounded(
          onPressed: () {},
          label: 'Continue',
        ),
      ],
    );
  }
}
