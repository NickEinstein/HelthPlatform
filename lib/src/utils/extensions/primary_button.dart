import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

import '../../resources/colors/colors.dart';
import '../../resources/textstyles/app_textstyles.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? label;
  final Color? textColor;
  final double? width;
  final String? preIcon;
  final String? postIcon;
  final double preIconSpace;
  final double postIconSpace;
  //final Color borderColor;
  final Color? backgroundColor;
  final bool isOutline;
  final double height;
  final TextStyle? textStyle;
  final Color shadowColor;
  final Color? iconColor;
  final Widget? child;
  final double borderWidth;

  final double radius;

  final bool isText;

  const AppButton({
    super.key,
    required this.onPressed,
    this.label,
    this.borderWidth = 1,
    this.textStyle,
    this.shadowColor = const Color.fromARGB(73, 158, 158, 158),
    this.preIcon,
    this.postIcon,
    this.iconColor,
    this.backgroundColor,
    this.postIconSpace = 20,
    this.preIconSpace = 20,
    this.textColor,
    this.height = 55,
    this.child,
    this.width = double.infinity,
    this.radius = 5,
  })  : assert(label != null || child != null),
        isText = false,
        isOutline = false;

  const AppButton.rounded({
    super.key,
    required this.onPressed,
    this.label,
    this.borderWidth = 0,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    this.shadowColor = Colors.transparent,
    this.preIcon,
    this.postIcon,
    this.iconColor,
    this.backgroundColor = const Color(0xff00B908),
    this.postIconSpace = 20,
    this.preIconSpace = 20,
    this.textColor,
    this.height = 51,
    this.child,
    this.width = double.infinity,
    this.radius = 300,
  })  : assert(label != null || child != null),
        isText = false,
        isOutline = false;

  const AppButton.outline({
    super.key,
    required this.onPressed,
    this.label,
    this.borderWidth = 1,
    this.textStyle,
    this.preIcon,
    this.iconColor,
    this.postIcon,
    this.postIconSpace = 8,
    this.preIconSpace = 8,
    this.shadowColor = Colors.transparent,
    this.height = 55,
    this.child,
    this.width = double.infinity,
    this.radius = 5,
  })  : assert(label != null || child != null),
        isText = true,
        textColor = null,
        backgroundColor = null,
        isOutline = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(8),
          shadowColor: backgroundColor != null
              ? const WidgetStatePropertyAll(Colors.transparent)
              : WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.transparent;
                  } else {
                    return shadowColor;
                  }
                }),
          foregroundColor: textColor != null
              ? WidgetStatePropertyAll(textColor)
              : WidgetStateProperty.resolveWith((states) {
                  if (isOutline) {
                    return AppColors.primary;
                  } else if (states.contains(WidgetState.disabled)) {
                    return AppColors.greyQuatinary;
                  } else if (isOutline) {
                    return AppColors.primary;
                  } else if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return AppColors.primary400;
                  } else {
                    return Colors.white;
                  }
                }),
          textStyle: WidgetStatePropertyAll(CustomTextStyle.textmedium16.w700),
          backgroundColor: backgroundColor != null
              ? WidgetStatePropertyAll(backgroundColor)
              : WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return const Color(0xffE2E2E2);
                  } else if (isOutline) {
                    return Colors.transparent;
                  } else if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return AppColors.primary400;
                  }
                  return AppColors.primary;
                }),
          fixedSize: WidgetStatePropertyAll(
              width == null ? Size.fromHeight(height) : Size(width!, height)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: isOutline
                  ? const BorderSide(
                      color: Color(0xff3C3C3E),
                      width: 0.5,
                    )
                  : BorderSide.none,
            ),
          ),
        ),
        child: child == null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (preIcon != null) ...[
                    SvgPicture.asset(
                      preIcon!,
                      color: iconColor ?? textColor,
                    ),
                    preIconSpace.spacingW,
                  ],
                  Text(
                    label!,
                    style: CustomTextStyle.textmedium16.w700,
                  ),
                  if (postIcon != null) ...[
                    postIconSpace.spacingW,
                    SvgPicture.asset(
                      postIcon!,
                      color: iconColor ?? textColor,
                    ),
                  ],
                ],
              )
            : child!,
      ),
    );
  }
}
