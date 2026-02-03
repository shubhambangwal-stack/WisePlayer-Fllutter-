import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/core/utils/get_device_info.dart';
import 'package:wise_players/core/utils/get_dymention.dart';
import 'package:wise_players/presentation/screen_view/common/auth/fetch_phone_info_mac.dart';
import 'package:wise_players/presentation/screen_view/common/auth/login_with_mac.dart';
import 'package:wise_players/presentation/screen_view/common/splash/splash_screen.dart';
import 'package:wise_players/presentation/screen_view/mobile/dashboard.dart';

import '../web/web_dashboard_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ScreenLayoutScreen extends StatelessWidget {
  static const String routeName = AppRoutes.screenLayout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          mWidth = constraints.maxWidth;
          mHeight = constraints.maxHeight;
          log("your device width is $mWidth and height:= $mHeight");
          if (constraints.maxWidth < 700) {
            // getDeviceInfo();
            isPhone = true;
            return FetchPhoneInfoMac();
            // return DashboardScreen();
          } else {
            isweb = true;
            isPhone = false;
            // return WebDashboardScreen();
            return FetchPhoneInfoMac();
          }
        },
      ),
    );
  }
}
