import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wise_players/core/const/api/onboardingApi.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/presentation/screen_view/responsive/responsive_layout.dart';
import 'package:wise_players/presentation/screen_view/mobile/dashboard.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = AppRoutes.splashScreen;

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      goDashboard(context);
    });
  }

  goDashboard(context) {
    Future.delayed(Duration(seconds: 2), () {
      GoRouter.of(context).go(ScreenLayoutScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(height: 100, width: 200, child: Image.asset(applogo)),
      ),
    );
  }
}
