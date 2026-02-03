import 'package:flutter/material.dart';
import 'package:wise_players/core/utils/floating_buttons.dart';

import '../../../../../core/colors/colors.dart';

class TabChangeButton extends StatelessWidget {
  const TabChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        floatingNextButton(
          onPress: () {},
          child: Icon(Icons.home, color: AppColor.red),
        ),
        const SizedBox(height: 10),
        floatingNextButton(
          onPress: () {},
          child: Icon(Icons.search, color: AppColor.brownGrey),
        ),
        const SizedBox(height: 10),
        floatingNextButton(
          onPress: () {},
          child: Icon(Icons.live_tv, color: AppColor.brownGrey),
        ),
        const SizedBox(height: 10),
        floatingNextButton(
          onPress: () {},
          child: Icon(Icons.favorite_border, color: AppColor.brownGrey),
        ),
        const SizedBox(height: 10),
        floatingNextButton(
          onPress: () {},
          child: Icon(Icons.person_outline, color: AppColor.brownGrey),
        ),
      ],
    );
  }
}
