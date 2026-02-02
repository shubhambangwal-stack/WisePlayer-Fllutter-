import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/localization/generated/l10n.dart';
import 'package:wise_players/core/routes/router.dart';

void main() {
  // if (kIsWeb) {
  //   WidgetsBinding.instance.platformDispatcher.onReportTimings = null;
  // }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Locale locale = Locale('en');
    return MaterialApp.router(
      routerConfig: router,
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Wise Player',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.background,
        appBarTheme: AppBarTheme(backgroundColor: AppColor.background),
        useMaterial3: true,
      ),
      // home: Scaffold(body: Center(child: Text("Jay Shree Ram"))),
      // home: ScreenLayoutScreen(),
      // home: DashboardScreen(),

      // ),
    );
  }
}
