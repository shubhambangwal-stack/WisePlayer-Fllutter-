import 'package:flutter/material.dart';

double mHeight = 0;
double mWidth = 0;
bool isPhone = false;
bool isweb = false;
getDymentation(context) {
  mHeight = MediaQuery.sizeOf(context).height;
  mWidth = MediaQuery.sizeOf(context).width;
  return;
}
