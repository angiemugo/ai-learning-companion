import 'package:flutter/material.dart';

class AppColors {
  // Primary Purple Palette
  static final Color primary = Colors.purple[400]!;
  static final Color primaryLight = Colors.purple[300]!;
  static final Color primaryDark = Colors.purple[600]!;
  static final Color primaryVariant = Colors.purple[800]!;
  
  // Surface Colors
  static final Color scaffoldBackground = Colors.purple[50]!;
  static const Color surface = Colors.white;
  
  // Shadow Colors
  static final Color shadow = Colors.purple.withValues(alpha: 0.5);
  static final Color shadowLight = Colors.purple.withValues(alpha: 0.4);
  
  // Text Colors
  static final Color textPrimary = Colors.purple[700]!;
  static final Color textSecondary = Colors.purple[600]!;
  static const Color textOnPrimary = Colors.white;
  
  // Border Colors
  static final Color borderDefault = Colors.purple[300]!;
  static final Color borderFocused = Colors.purple[600]!;
  static const Color borderError = Colors.red;
  
  // Status Colors
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  
  // Accent Colors
  static final Color accent = Colors.purple[400]!;
  static final Color accentLight = Colors.purple[200]!;
  
  // Component-specific colors
  static final Color appBarBackground = Colors.purple[400]!;
  static final Color buttonBackground = Colors.purple[400]!;
  static final Color snackBarBackground = Colors.purple[600]!;
  static final Color fabBackground = Colors.purple[400]!;
  static final Color iconColor = Colors.purple[600]!;
}