import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF002C58), // Primary deep blue
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF002C58),
      secondary: Color(0xFFE5A812), // Accent vibrant yellow-orange
      surface: Color(0xFFFFFFFF), // White surface
      onPrimary: Color(0xFFFFFFFF), // White text on primary
      onSecondary: Color(0xFF002C58), // Deep blue text on secondary
      onSurface: Color(0xFF1F2937), // Text on surface
    ),
    scaffoldBackgroundColor:
        const Color(0xFFF8F9FA), // Light scaffold background
    appBarTheme: const AppBarTheme(
      color: Color(0xFF002C58), // AppBar color
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      displaySmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
      bodySmall: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFFE5A812), // Accent yellow button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFE5A812), // Accent yellow for FAB
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
      space: 16,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF002C58), // Deep blue
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF002C58),
      secondary: Color(0xFFE5A812), // Accent yellow-orange
      surface: Color(0xFF1F2937), // Dark surface
      onPrimary: Color(0xFFFFFFFF), // White text on primary
      onSecondary: Color(0xFF002C58), // Deep blue text on secondary
      onSurface: Color(0xFFEDEFF1), // Light text on surface
    ),
    scaffoldBackgroundColor:
        const Color(0xFF181A1B), // Dark scaffold background
    appBarTheme: const AppBarTheme(
      color: Color(0xFF002C58), // AppBar color
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      displaySmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      titleLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFEDEFF1)),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF9CA3AF)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
      bodySmall: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1F2937),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFFE5A812), // Accent yellow button
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFE5A812), // Accent yellow for FAB
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF374151),
      thickness: 1,
      space: 16,
    ),
  );

  static void toggleTheme() {
    Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
  }
}
