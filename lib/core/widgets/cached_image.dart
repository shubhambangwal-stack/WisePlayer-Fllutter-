import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final imageUrl;
  final double height;
  final double width;
  final Widget errorWidget;
  CachedImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.errorWidget = const Icon(Icons.error),
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 252, 252, 252),
        highlightColor: const Color.fromARGB(255, 206, 206, 206),
        child: Container(height: height, width: width),
      ),
      errorWidget: (context, url, error) => errorWidget,
      imageUrl: imageUrl,
    );
  }
}
