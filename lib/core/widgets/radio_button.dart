// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class RadioButton extends StatelessWidget {
  final double height;
  final double width;
  final bool isSelected;
  final Color dotColor;
  final Color outerColor;
  final VoidCallback? onTap;
  const RadioButton({
    Key? key,
    this.height = 20,
    this.width = 20,
    this.isSelected = true,
    this.dotColor = AppColor.darkBrownRed,
    this.outerColor = AppColor.darkBrownRed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: outerColor),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? dotColor : Colors.transparent,
              borderRadius: BorderRadius.circular(height / 4),
            ),
          ),
        ),
      ),
    );
  }
}
