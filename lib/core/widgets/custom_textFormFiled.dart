import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFiled extends StatefulWidget {
  final FocusNode? focusNode;
  final bool isReadOnly;
  final TextEditingController controller;
  final String hintText;
  final double borderRadius;
  final Color borderSideColor;
  final Color fixedBorderSideColor;
  final bool isFilled;
  final bool obscureText;
  final Color filledColor;
  final int maxLines;
  final int? maxWords;
  final TextInputType keyboardType;
  final bool isEnabled;
  final bool isDigitsOnly;
  final bool isPreFixText;
  final String? prefixText;
  final bool isBorder;
  final Color fillColor;
  final bool isPreFixIcon;

  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool autoFoucs;
  final Function(String?)? onSave;
  final bool isOnChanged;
  final Function(String)? onChanged;

  const CustomTextFormFiled({
    super.key,
    required this.controller,
    this.hintText = "",
    this.prefixIcon = const SizedBox(),
    this.isReadOnly = false,
    this.borderRadius = 11,
    this.borderSideColor = Colors.grey,
    this.isFilled = false,
    this.obscureText = false,
    this.filledColor = Colors.white,
    this.fixedBorderSideColor = Colors.black,
    this.maxLines = 1,
    this.maxWords,
    this.keyboardType = TextInputType.name,
    this.isEnabled = true,
    this.isDigitsOnly = false,
    this.isPreFixText = false,
    this.prefixText,
    this.isBorder = true,
    this.fillColor = Colors.white,
    this.isPreFixIcon = false,
    this.focusNode,
    this.suffixIcon = const SizedBox(),
    this.autoFoucs = false,
    this.onSave,
    this.isOnChanged = false,
    this.onChanged,
  });

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFoucs,
      focusNode: widget.focusNode != null ? widget.focusNode : FocusNode(),
      // textAlignVertical: TextAlignVertical(y: 0.9),
      inputFormatters: widget.isDigitsOnly
          ? [
              FilteringTextInputFormatter.digitsOnly, // Allows only numbers
            ]
          : null,
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxWords,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      controller: widget.controller,
      onSaved: widget.onSave,
      onChanged: widget.isOnChanged ? widget.onChanged : null,

      decoration: InputDecoration(
        filled: widget.isFilled,
        fillColor: widget.fillColor,
        hintText: widget.hintText,

        // prefix: Padding(
        //   padding: EdgeInsets.only(top: 12), // adjust as needed
        //   child: Icon(Icons.message),
        // ),
        prefixIcon: widget.isPreFixIcon ? widget.prefixIcon : null,

        suffixIcon: widget.suffixIcon,
        hintStyle: TextStyle(color: Colors.grey),
        prefixStyle: TextStyle(color: Colors.grey),
        prefixText: widget.isPreFixText ? "${widget.prefixText}: " : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: widget.isBorder
              ? BorderSide(width: 1.3, color: widget.borderSideColor)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: widget.isBorder
              ? BorderSide(width: 2, color: widget.fixedBorderSideColor)
              : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(width: 1.3, color: widget.borderSideColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: widget.isBorder
              ? BorderSide(width: 1.3, color: widget.borderSideColor)
              : BorderSide.none,
        ),
      ),
    );
  }
}
