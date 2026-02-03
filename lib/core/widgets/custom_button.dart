import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color backgroundColor;
  final double borderRadius;
  final Widget child;
  final IconData? icon;
  final double? iconSize;
  final bool isBorderSide;
  final Color borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor = AppColor.coralRed,
    this.borderRadius = 10,
    this.icon,
    this.iconSize = 15,
    this.isBorderSide = false,
    this.borderColor = AppColor.coralRed,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          // enabledMouseCursor: SystemMouseCursors.click,
          padding: EdgeInsets.all(0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: isBorderSide
                ? BorderSide(color: borderColor, width: borderWidth)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: iconSize) : null,
        label: child,
      ),
    );
  }
}
