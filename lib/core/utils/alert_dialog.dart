import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../widgets/custom_text.dart';

Future<void> alertDialog({
  required BuildContext context,
  Widget? title,
  Widget? content,

  required String cancel,
  required VoidCallback onTap,
  required String okk,
  VoidCallback? cancelOnTap,
  Color cancelButtonBackgroundColor = AppColor.red,
  Color cancelTextColor = AppColor.white,
  Color okkButtonBackgroundColor = AppColor.red,
  Color okkTextColor = AppColor.white,
}) async {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              backgroundColor: cancelButtonBackgroundColor,
            ),

            onPressed:
                cancelOnTap ??
                () {
                  Navigator.maybePop(context);
                },
            child: CText(cancel, color: cancelTextColor),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: okkButtonBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            onPressed: onTap,
            child: CText(okk, color: okkTextColor),
          ),
        ],
      );
    },
  );
}
