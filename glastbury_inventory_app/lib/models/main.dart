// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/landing_screen.dart'; // Import the starting screen

void main() {
  // 💡 Flutter's main entry point
  runApp(const InventoryApp());
}

// 🎨 Define the elegant Light Theme (White background)
final ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF0D47A1), // Deep Blue Primary
  scaffoldBackgroundColor: Colors.white, // Clean White Background
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0D47A1), // Blue AppBar
    foregroundColor: Colors.white,      // White text/icons
    elevation: 4,
  ),
  // Define color scheme, ensuring the Red Accent is available
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.redAccent, // Red Accent for Floating/Action buttons
    background: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Color(0xFF0D47A1)),
  ),
  // Style for consistent button appearance
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D47A1), 
      foregroundColor: Colors.white,
    ),
  ),
  useMaterial3: true,
);

// 🎨 Define the elegant Dark Theme (Black background)
final ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF0D47A1), // Deep Blue Primary
  scaffoldBackgroundColor: Colors.black, // Elegant Black Background
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0D47A1),
    foregroundColor: Colors.white,
    elevation: 4,
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.redAccent, // Red Accent
    background: Colors.black,
    brightness: Brightness.dark, // Essential for Dark Mode
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Color(0xFF0D47A1)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D47A1),
      foregroundColor: Colors.white,
    ),
  ),
  useMaterial3: true,
);

// 💡 Stateful Widget to manage the application's overall state, including the Theme Mode.
class InventoryApp extends StatefulWidget {
  const InventoryApp({super.key});

  // 🚀 Helper method: Allows child widgets (like SettingsScreen) to access 
  // and modify the theme state easily without complex routing/providers.
  static _InventoryAppState of(BuildContext context) => 
      context.findAncestorStateOfType<_InventoryAppState>()!;

  @override
  State<InventoryApp> createState() => _InventoryAppState();
}

class _InventoryAppState extends State<InventoryApp> {
  // 💡 State variable to hold the current theme mode (defaults to Light)
  ThemeMode _themeMode = ThemeMode.light;

  // 🚀 Public function called by the Settings screen to switch the theme
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glastbury Stores',
      theme: lightTheme, // Base Light Theme
      darkTheme: darkTheme, // Base Dark Theme
      themeMode: _themeMode, // 💡 Applies the currently selected theme
      home: const LandingScreen(), // Application starts here
      debugShowCheckedModeBanner: false, 
    );
  }
}
