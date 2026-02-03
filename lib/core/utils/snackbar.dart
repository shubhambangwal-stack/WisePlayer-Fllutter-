import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';
import 'get_dymention.dart';

snackBar<Widget>(
  BuildContext context,
  String title, [
  backgroundColor = Colors.black,
]) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,

        behavior: SnackBarBehavior.floating,
        content: CText(color: Colors.white, title),
      ),
    );
}

topSnackBar<Widget>(
  BuildContext context,
  String title, [
  backgroundColor = Colors.black,
]) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(
      MaterialBanner(
        backgroundColor: backgroundColor,
        // margin: EdgeInsets.only(
        //   top: 10,
        //   left: 5,
        //   right: 5,
        //   bottom: mHeight * 0.9,
        // ),
        actions: [
          IconButton(
            onPressed: () {
              messenger.hideCurrentMaterialBanner();
            },
            icon: Icon(Icons.close),
          ),
        ],

        content: CText(color: Colors.white, title),
      ),
    );
  Future.delayed(const Duration(seconds: 2), () {
    messenger.hideCurrentMaterialBanner();
  });
}
