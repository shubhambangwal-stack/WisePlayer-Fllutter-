import 'package:flutter/material.dart';

import '../colors/colors.dart';

Widget buildOtpTextField({
  required BuildContext context,
  required TextEditingController? ctrl,
  required FocusNode? focusNode,
}) {
  return Container(
    height: 48,
    width: 48,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(27),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.number,

        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(
              context,
            ).previousFocus(); // last digit pr keyboard close
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          counterText: "",
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    ),
  );
}
