import 'package:flutter/material.dart';

/// Defines the custom themes for the Smart Calculator application.
///
/// This class provides static [ThemeData] instances for both light and dark modes,
/// ensuring a consistent and modern look across the application.
class Themes {
  /// The light theme for the application.
  ///
  /// Features a blue primary color, light background, and white surface.
  /// Uses the 'Roboto' font family and defines specific styles for the app bar
  /// and elevated buttons.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      surface: Color(0xFFF0F0F0),
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );

  /// The dark theme for the application.
  ///
  /// Features a blue primary color, dark background, and a darker surface.
  /// Uses the 'Roboto' font family and defines specific styles for the app bar
  /// and elevated buttons, optimized for a dark environment.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      surface: Color(0xFF121212),
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}
