import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/widgets/cached_image.dart';
import 'package:wise_players/core/widgets/custom_button.dart';
import 'package:wise_players/core/widgets/custom_text.dart';

import '../../../../../../core/const/api/onboardingApi.dart';
import '../../../../../../core/utils/get_dymention.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ValueNotifier<int> carouselDot = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    log("Homepage loading again");
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            trandingSlider(),
            // _heroBanner(),
            _section("Recommended for you"),
            _section("Trending Now"),
            _section("Recently Watched", height: 140),
            _liveTvSection(),
          ],
        ),
      ),
    );
  }

  trandingSlider() {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 2, color: Colors.white),
      ),
      height: 245,
      width: isPhone ? mWidth : 600,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            height: 225,
            width: isPhone ? mWidth : 600,
            child: CarouselSlider(
              items: onboardingData
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: CachedImage(
                              imageUrl: e['image'],
                              height: 230,
                              width: isPhone ? mWidth : 600,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 20,
                            child: CustomButton(
                              borderRadius: 5,
                              height: 20,
                              width: 100,
                              icon: Icons.play_arrow,
                              child: CText("Watch Now", fontSize: 12),
                              onPressed: () {},
                            ),
                          ),

                          // ElevatedButton.icon(
                          //   onPressed: () {},

                          //   label: CText("Watch now"),
                          // ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (valueIndex, reason) {
                  carouselDot.value = valueIndex;
                },
              ),
            ),
          ),
          // const Text("--------------------------------------------"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => ValueListenableBuilder(
                valueListenable: carouselDot,
                builder: (context, value, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: value == index ? 13 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: value == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  // ---------------- APP BAR ----------------
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Image(image: AssetImage(applogo), height: 20),
      centerTitle: true,
      actions: const [
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(width: 16),
      ],
    );
  }

  // ---------------- SECTION ----------------
  Widget _section(String title, {double height = 77}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(title),
        const SizedBox(height: 10),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (_, index) => _posterCard(),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CText(title, fontSize: 16, fontWeight: FontWeight.w600),
          InkWell(child: CText("See All", color: AppColor.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _posterCard() {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage(demoImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ---------------- LIVE TV ----------------
  Widget _liveTvSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 10,
        children: [
          _liveChip("CINE"),
          _liveChip("SPORTS"),
          _liveChip("NEWS"),
          _liveChip("MUSIC"),
          _liveChip("KIDS"),
        ],
      ),
    );
  }

  Widget _liveChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, color: Colors.red, size: 8),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
