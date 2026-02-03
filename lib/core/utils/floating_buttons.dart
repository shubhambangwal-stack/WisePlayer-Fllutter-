import 'package:flutter/material.dart';

import '../colors/colors.dart';

Widget floatingNextButton({
  required VoidCallback onPress,
  Widget child = const Icon(
    Icons.arrow_forward_outlined,
    color: AppColor.brownGrey,
  ),
  Color color = AppColor.white,
}) {
  return FloatingActionButton.small(
    backgroundColor: color,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(35),
    ),
    child: child,
    onPressed: onPress,
  );
}
