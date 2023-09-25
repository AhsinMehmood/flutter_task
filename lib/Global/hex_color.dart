import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

// ahsin006@ligudi.com
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

final colorPurple = '845EC2';
final colorGrey80 = 'BABABA';
final colorBlack60 = '8A8A8D';
final colorBlue100 = '5CB8E4';
final colorBlue20 = 'DEF0F9';
final colorGreen100 = '16C79A';
final colorGreen20 = 'D0F3EA';
final colorOrange100 = 'F99417';
final colorOrange20 = 'FDE9D0';
final colorRed100 = 'F1526A';
final colorRed20 = 'FCDCE1';
final colorGrey100 = '9D9D9D';
final colorGrey20 = 'EBEBEB';
final colorYellow100 = 'FFC23C';
final colorYellow20 = 'FFF2D8';
