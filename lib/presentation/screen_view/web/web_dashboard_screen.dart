import 'package:flutter/material.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/const/api/onboardingApi.dart';
import 'package:wise_players/core/routes/routes_path.dart';

import 'screens/channels/channels.dart';
import 'screens/show_playListvideo/show_playList_video.dart';
import 'screens/tab_button/tab_change_button.dart';

class WebDashboardScreen extends StatefulWidget {
  static const String routeName = AppRoutes.webDashboard;
  const WebDashboardScreen({super.key});

  @override
  State<WebDashboardScreen> createState() => _WebDashboardScreenState();
}

class _WebDashboardScreenState extends State<WebDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColor.black,
        title: Image(image: AssetImage(applogo)),
      ),
      body: Row(
        children: [
          SizedBox(width: 70, child: TabChangeButton()),

          const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),

          Expanded(flex: 3, child: Channels()),
          const SizedBox(width: 10),
          Expanded(flex: 10, child: ShowPlaylistVideo()),
        ],
      ),
    );
  }
}
