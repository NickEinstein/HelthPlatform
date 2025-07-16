import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../resources/textstyles/app_textstyles.dart';

Widget buildRecordTile({
  required String title,
  String? subtitle,
  required String icon,
  bool isSubtitle = true,
  bool isColor = false,
  required VoidCallback onTap,
  bool isSvg = false,
  bool isCircle = false,
  bool dropDown = false,
  bool isForwardIcon = true,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: ShapeDecoration(
        color: isColor ? Colors.transparent : const Color(0xffE9ECFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          buildIcon(icon, isSvg, isCircle),
          const SizedBox(width: 26),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isSubtitle
                      ? CustomTextStyle.textsmall15.w700
                          .withColorHex(0xff343333)
                      : CustomTextStyle.textsmall15.w400
                          .withColorHex(0xff343333),
                ),
                const SizedBox(height: 5),
                isSubtitle
                    ? Text(
                        subtitle!,
                        style: CustomTextStyle.textxSmall13
                            .withColorHex(0xff909090),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          if (isForwardIcon)
            dropDown
                ? Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: const Color(0xff3C4BAC).withOpacity(0.5),
                  )
                : Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: const Color(0xff3C4BAC).withOpacity(0.5),
                  ),
        ],
      ),
    ),
  );
}

Widget buildGrayRecordTile({
  required String title,
  String? subtitle,
  required String icon,
  bool isSubtitle = true,
  bool isColor = false,
  required VoidCallback onTap,
  bool isSvg = false,
  bool isCircle = false,
  bool dropDown = false,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: isColor
                ? Color(0xffCACACA)
                : Color(0xffCACACA).withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(7)),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const ShapeDecoration(
              color: Color(0xFFEEEEEE),
              shape: OvalBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                icon,
                height: 30,
                width: 30,
              ),
            ),
          ),
          const SizedBox(width: 26),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isSubtitle
                      ? CustomTextStyle.textsmall15.w700
                          .withColorHex(0xff343333)
                      : CustomTextStyle.textsmall15.w400
                          .withColorHex(0xff343333),
                ),
                const SizedBox(height: 5),
                isSubtitle
                    ? Text(
                        subtitle!,
                        style: CustomTextStyle.textxSmall13
                            .withColorHex(0xff909090),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          dropDown
              ? Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: const Color(0xffB3B3B3),
                )
              : SizedBox.shrink(),
        ],
      ),
    ),
  );
}

Widget buildIcon(String icon, bool isSvg, bool isCircle) {
  if (isCircle) {
    return Container(
      width: 50,
      height: 50,
      decoration: const ShapeDecoration(
        color: Color(0xFFCBD2FF),
        shape: OvalBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          icon,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
  return isSvg
      ? SvgPicture.asset(icon, height: 30, width: 30)
      : Image.asset(icon, height: 50, width: 50);
}
