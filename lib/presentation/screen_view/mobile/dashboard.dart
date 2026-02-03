import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wise_players/core/routes/routes_path.dart';
import 'package:wise_players/core/utils/get_dymention.dart';
import 'package:wise_players/core/widgets/custom_text.dart';
import 'package:wise_players/presentation/screen_view/common/tabs/homepage/screens/homepage.dart';
import 'package:wise_players/presentation/screen_view/common/tabs/live_tv/screens/live_tv.dart';
import 'package:wise_players/presentation/screen_view/common/tabs/mylist/screens/favourite_list.dart';
import 'package:wise_players/presentation/screen_view/common/tabs/profile/screens/user_profile.dart';
import 'package:wise_players/presentation/screen_view/common/tabs/search/screens/search_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = AppRoutes.dashboard;
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tabIndex = 0;

  final List<Widget?> _pages = List.filled(5, SizedBox.shrink());

  Widget _getPage(int index) {
    if (_pages[index] is SizedBox) {
      _pages[index] = [
        Homepage(),
        SearchScreen(),
        LiveTv(),
        FavouriteList(),
        UserProfile(),
      ][index];
    }

    return _pages[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: List.generate(5, (index) => _getPage(index)),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  // ---------------- APP BAR ----------------
  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: const Text(
        "WISE PLAYER",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  // ---------------- HERO BANNER ----------------
  Widget _heroBanner() {
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://via.placeholder.com/800x400"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.9), Colors.transparent],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "DHURANDHAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text("Watch Now"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- SECTION ----------------
  Widget _section({
    required String title,
    required int itemCount,
    double height = 180,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title),
          const SizedBox(height: 10),
          SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return _posterCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text("See All", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _posterCard() {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage("https://via.placeholder.com/200x300"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ---------------- LIVE TV ----------------
  Widget _liveTvSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _liveChip("CINE"),
          _liveChip("SPORTS"),
          _liveChip("NEWS"),
          _liveChip("MUSIC"),
        ],
      ),
    );
  }

  Widget _liveChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Colors.red, size: 8),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // ---------------- BOTTOM NAV ----------------
  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: tabIndex,
      onTap: (value) {
        tabIndex = value;

        setState(() {});
      },

      backgroundColor: Colors.black,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.search),
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.live_tv),
          icon: Icon(Icons.live_tv_outlined),
          label: "Live TV",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite_border),
          label: "My List",
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
