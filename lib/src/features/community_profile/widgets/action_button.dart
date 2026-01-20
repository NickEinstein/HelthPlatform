import 'package:flutter/material.dart';
import 'package:greenzone_medical/src/app_pkg.dart';
import 'package:greenzone_medical/src/utils/extensions/widget_extensions.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final IconData? icon;
  final bool isLight;
  final bool isOutlined;
  final bool isGrey;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.isPrimary,
    this.icon,
    this.isLight = false,
    this.isOutlined = false,
    this.isGrey = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isPrimary
        ? ColorConstant.primaryColor
        : isLight
            ? const Color(0xFFD4F3B3) // Light Green
            : isGrey
                ? Colors.grey.shade400
                : Colors.white;
    Color textColor = isPrimary
        ? Colors.white
        : isLight || isGrey
            ? Colors.black87
            : ColorConstant.primaryColor;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.white : backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: isOutlined ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: textColor),
                4.width,
              ],
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
