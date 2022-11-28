import 'package:flutter/material.dart';



import 'font_manager.dart';

TextStyle _getTextStyle({
  required Color color,
  double fontSize = 12,
  required fontWeight,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstants.fontFamilyMontserrat,
  );
}

TextStyle getRegularStyle({
  required Color color,
  double fontSize = 12,
}) {
  return _getTextStyle(
      color: color, fontWeight: FontWeightManager.regular, fontSize: fontSize);
}

TextStyle getBoldStyle({
  required Color color,
  double fontSize = 12,
}) {
  return _getTextStyle(
      color: color, fontWeight: FontWeightManager.bold, fontSize: fontSize);
}

TextStyle getMediumStyle({
  required Color color,
  double fontSize = 12,
}) {
  return _getTextStyle(
      color: color, fontWeight: FontWeightManager.medium, fontSize: fontSize);
}

TextStyle getSemiBoldStyle({
  required Color color,
  double fontSize = 12,
}) {
  return _getTextStyle(
      color: color, fontWeight: FontWeightManager.semiBold, fontSize: fontSize);
}

TextStyle getLightStyle({
  required Color color,
  double fontSize = 12,
}) {
  return _getTextStyle(
      color: color, fontWeight: FontWeightManager.light, fontSize: fontSize);
}
