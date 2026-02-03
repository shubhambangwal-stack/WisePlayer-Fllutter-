import 'package:flutter/material.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/widgets/custom_text.dart';

class Channels extends StatefulWidget {
  const Channels({super.key});

  @override
  State<Channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels> {
  int channelIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          color: channelIndex == index ? AppColor.coralRed : null,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              channelIndex = index;
              setState(() {});
            },
            title: CText("Channel $index"),
            subtitle: CText("Total ${index + 80}", fontSize: 12),
          ),
        );
      },
    );
  }
}
