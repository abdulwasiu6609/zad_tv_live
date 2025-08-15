import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF007BFF), // Zad blue
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.openSans(color: Colors.white70),
    ),
  );
}
