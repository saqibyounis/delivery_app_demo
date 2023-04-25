import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData basicTheme = _buildBasicTheme();

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: base.displayLarge.copyWith(fontFamily: 'GoogleSans'),
    displayMedium: base.displayMedium.copyWith(fontFamily: 'GoogleSans'),
    displaySmall: base.displaySmall.copyWith(fontFamily: 'GoogleSans'),
  );
}

ThemeData _buildBasicTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    primaryColor: primaryColor,
    primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: primaryColor,
    accentColor: secondaryColor,
    errorColor: Colors.red,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(color: primaryColor),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}
