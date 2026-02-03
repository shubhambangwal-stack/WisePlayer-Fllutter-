import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wise_players/core/colors/colors.dart';

class CText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final int? maxLines;
  final bool? isSoftWrap;
  final String GoogleFontName;
  const CText(
    this.text, {
    super.key,

    this.color = AppColor.white,
    this.fontSize = 15.0,
    this.fontWeight = FontWeight.w500,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.GoogleFontName = "popines",
    this.maxLines,
    this.isSoftWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: isSoftWrap,
      text,
      style: GoogleFontName == "popines"
          ? GoogleFonts.poppins(
              color: color,
              fontSize: fontSize,
              decoration: TextDecoration.combine([]),
              fontWeight: fontWeight,
            )
          : GoogleFonts.montserrat(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),

      // style: TextStyle(
      //     color: color,
      //     fontSize: fontsize,
      //     fontWeight: fontWeight,
      //     overflow: overflow),
    );
  }
}
