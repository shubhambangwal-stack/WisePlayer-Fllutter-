import 'package:flutter/material.dart';

Widget assetImage({
  required String assetImageUrl,
  required double height,
  required double width,
  BoxFit fit = BoxFit.cover,
}) {
  return Image(
    fit: BoxFit.cover,
    height: height,
    width: width,
    image: AssetImage(assetImageUrl),
  );
}
