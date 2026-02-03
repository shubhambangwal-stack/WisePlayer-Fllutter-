import 'package:flutter/material.dart';

import '../colors/colors.dart';

void loader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent user from closing by tapping outside
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.red),
      );
    },
  );
}

void stopLoader(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
