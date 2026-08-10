import 'package:flutter/material.dart';

/// Centralized light mode color palette for Po Po Kyaw's UI/UX Portfolio.
class AppColors {
  AppColors._();

  // Primary Light Surfaces
  static const Color background = Color(0xFFF8FAFC); // Slate off-white background
  static const Color surface = Color(0xFFFFFFFF);    // Card container surface
  static const Color cardSurface = Color(0xFFF1F5F9); // Elevated card surface
  static const Color glassSurface = Color(0xCCFFFFFF); // Translucent white glass
  static const Color glassBorder = Color(0xFFE2E8F0);  // Glass border accent

  // Brand Accent Gradients & Neon Colors
  static const Color cyanAccent = Color(0xFF0284C7);   // Rich vibrant sky cyan/blue
  static const Color blueAccent = Color(0xFF2563EB);   // Electric royal blue
  static const Color purpleAccent = Color(0xFF7C3AED); // Deep violet accent
  static const Color pinkAccent = Color(0xFFDB2777);   // Magenta accent
  static const Color coralAccent = Color(0xFFF43F5E);  // Coral badge highlight

  // Text Hierarchy for Light Mode
  static const Color textPrimary = Color(0xFF0F172A);   // High-contrast charcoal black
  static const Color textSecondary = Color(0xFF475569); // Slate gray
  static const Color textMuted = Color(0xFF64748B);     // Dimmed subtitle gray

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderSubtle = Color(0xFFCBD5E1);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyanAccent, blueAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [purpleAccent, pinkAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      Color(0xF8F8FAFC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient heroGlowGradient = RadialGradient(
    colors: [
      Color(0x1F0284C7),
      Color(0x0D7C3AED),
      Colors.transparent,
    ],
    radius: 0.8,
  );
}
