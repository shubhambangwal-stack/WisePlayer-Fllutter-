import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? traling;
  CustomAppbar({
    super.key,
    this.title,
    this.leading,
    this.traling,
  });
// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title, leading: leading, leadingWidth: 90, actions: [
      Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: traling,
      ),
    ]);
  }
}
