import 'package:flutter/material.dart';

const Color kcPrimaryColor = Color(0xFF9600FF);
const Color kcPrimaryColorDark = Color(0xFF300151);
const Color kcDarkGreyColor = Color(0xFF1A1B1E);
const Color kcMediumGrey = Color(0xFF474A54);
const Color kcLightGrey = Color.fromARGB(255, 187, 187, 187);
const Color kcVeryLightGrey = Color(0xFFE3E3E3);
const Color kcBackgroundColor = kcDarkGreyColor;

Color blackPrimaryColor = Colors.black;

Color kColorGrey = const Color(0xff3b3b3b);
Color kPrimaryGrey = Colors.grey;
Color fillBoxGrey = Colors.grey.shade200;

Color whitePrimaryColor = Colors.white;

Color kPrimaryGreen = Colors.green;
Color kPrimaryRed = Colors.red;

//fontsizes
double extraSmallFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.03;
}

double smallFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.035;
}

double mediumFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.04;
}

double extraMediumFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.045;
}

double largeFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.05;
}

double extraLargeFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.055;
}

double bigFontSize(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.06;
}
