import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/presentation/screen_view/common/auth/login_with_mac.dart';
import 'package:wise_players/presentation/screen_view/responsive/responsive_layout.dart';
import 'package:wise_players/presentation/screen_view/common/splash/splash_screen.dart';
import 'package:wise_players/presentation/screen_view/mobile/dashboard.dart';
import 'package:wise_players/presentation/screen_view/web/web_dashboard_screen.dart';
import '../shared_pref/shared_pref.dart';

final GoRouter router = GoRouter(
  // initialLocation: AppRoutes.getStarted,
  initialLocation: AppRoutes.splashScreen,
  redirect: (BuildContext context, GoRouterState state) async {},
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.screenLayout,
      builder: (context, state) => ScreenLayoutScreen(),
    ),

    GoRoute(
      path: AppRoutes.webDashboard,
      builder: (context, state) => WebDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginWithMac,
      builder: (context, state) {
        String deviceKey = state.extra as String;
        return LoginWithMac(deviceKey: deviceKey);
      },
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) {
        // final String scannerData = state.extra as String;

        return DashboardScreen();
      },
    ),
    // GoRoute(
    //   path: AppRoutes.scanQr,
    //   builder: (context, state) {
    //     // final String scannerData = state.extra as String;

    //     return ScannerPage();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.profilePage,
    //   pageBuilder: customTransition(
    //     pageBuilder: (state) {
    //       return UserProfile();
    //     },
    //   ),
    // ),

    // return UserProfile();
  ],
);

customTransition({
  // required Widget pageName,
  required Function(GoRouterState state) pageBuilder,
  startingDuration = 400,
  reverseDuration = 200,
}) {
  return (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,

      transitionDuration: Duration(milliseconds: startingDuration),
      reverseTransitionDuration: Duration(milliseconds: reverseDuration),
      child: pageBuilder(state),

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: true,
          child: child,
        );
      },
    );
  };
}
