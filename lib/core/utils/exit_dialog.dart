import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wise_players/core/colors/colors.dart';

import '../localization/generated/l10n.dart';

showExitDialog(BuildContext context, S s) async {
  return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s.exit),
            content: Text(s.exitConfirmMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // Return false
                },
                child: Text(
                  s.cancel,
                  style: TextStyle(color: AppColor.orangeRed),
                ),
              ),
              TextButton(
                onPressed: () async {
                  SystemNavigator.pop();
                },
                child: Text(
                  s.exit,
                  style: TextStyle(color: AppColor.steelGrey),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
