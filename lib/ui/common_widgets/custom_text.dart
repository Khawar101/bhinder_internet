import 'package:bhinder_internet/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  Color? color;
  bool localization;
  FontWeight? fontWeight;
  double? letterSpacing;
  double? wordspacing;
  TextAlign? textAlign;
  TextDirection? textDirection;
  TextOverflow? textOverflow;
  double? textScaleFactor;
  int? maxLines;
  bool? softWrap;
  CustomText(
      {super.key,
      this.text = "",
      this.color,
      this.localization = true,
      this.fontSize,
      this.fontWeight,
      this.letterSpacing,
      this.wordspacing,
      this.textAlign,
      this.textDirection,
      this.textOverflow,
      this.maxLines,
      this.textScaleFactor,
      this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ibmPlexSans(
        color: color ?? blackPrimaryColor,
        fontSize: fontSize ?? smallFontSize(context),
        // width*extraSmallFontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: letterSpacing ?? 0,
        wordSpacing: wordspacing ?? 0,
      ),
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      textScaleFactor: textScaleFactor,
      softWrap: softWrap,
    );
  }
}
