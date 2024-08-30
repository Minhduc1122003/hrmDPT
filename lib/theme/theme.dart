import 'package:flutter/material.dart';

class AppTheme {
static const Color primaryColor = Colors.blue;
static const Color secondaryColor = Colors.white;
static const Color backgroundColor = Colors.white;
static const Color textColor = Colors.black87;

static ThemeData get lightTheme {
  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: secondaryColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: secondaryColor,
      unselectedItemColor: secondaryColor.withOpacity(0.6),
    ),
  );
}
}