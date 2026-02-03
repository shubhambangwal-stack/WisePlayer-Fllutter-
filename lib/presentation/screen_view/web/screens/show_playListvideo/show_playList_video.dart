import 'package:flutter/material.dart';
import 'package:wise_players/core/colors/colors.dart';
import 'package:wise_players/core/widgets/custom_text.dart';

import '../../../../../core/const/api/onboardingApi.dart';

class ShowPlaylistVideo extends StatefulWidget {
  const ShowPlaylistVideo({super.key});

  @override
  State<ShowPlaylistVideo> createState() => _ShowPlaylistVideoState();
}

class _ShowPlaylistVideoState extends State<ShowPlaylistVideo> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 50,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        maxCrossAxisExtent: 150,
        childAspectRatio: 0.65,
      ),

      itemBuilder: (context, index) {
        return Container(
          width: 130,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: NetworkImage(demoImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 2,
                top: 2,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: CText("⭐ $index", fontSize: 10),
                ),
              ),

              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Icon(Icons.favorite_border),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  height: 50,
                  color: const Color.fromARGB(221, 0, 0, 0),
                  child: Column(
                    children: [
                      CText(
                        maxLines: 2,
                        "Maha Avatar Narshima Movie",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
