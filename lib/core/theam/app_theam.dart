import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    primaryColor: AppColors.primary,

    textTheme: GoogleFonts.cormorantGaramondTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBackground,
      foregroundColor: AppColors.title,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // Background
    scaffoldBackgroundColor: const Color(0xFF202124),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF202124),
      foregroundColor: Color(0xFFF5F5F5),
      elevation: 0,
    ),

    // Popup Menu
    cardColor: const Color(0xFF2D2E30),

    // Primary Color
    primaryColor: AppColors.primary,

    // Icons
    iconTheme: const IconThemeData(
      color: Color(0xFFF5F5F5),
    ),

    // Font
    textTheme: GoogleFonts.cormorantGaramondTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: const Color(0xFFF5F5F5),
      displayColor: const Color(0xFFF5F5F5),
    ),

    // Text Colors
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: Color(0xFF2D2E30),
      onSurface: Color(0xFFF5F5F5),
    ),
  );
  static ThemeData sepiaTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: const Color(0xffF4ECD8),

    primaryColor: const Color(0xff8B6F47),

    textTheme: GoogleFonts.cormorantGaramondTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffF4ECD8),
      foregroundColor: Colors.brown,
      elevation: 0,
    ),
  );
}