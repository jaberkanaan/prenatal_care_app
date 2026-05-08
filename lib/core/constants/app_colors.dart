import 'package:flutter/material.dart';

/// Application Color Palette
class AppColors {
  // ── Primary Colors ──────────────────────────────────
  static const Color primary = Color(0xFF7C3AED); // Deep Purple
  static const Color primaryLight = Color(0xFFEDE9FE);
  static const Color primaryDark = Color(0xFF6D28D9);

  // ── Secondary Colors ────────────────────────────────
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color secondaryLight = Color(0xFFCFFAFE);
  static const Color secondaryDark = Color(0xFF0E7490);

  // ── Trimester Colors ────────────────────────────────
  static const Color trimester1 = Color(0xFF10B981); // Green (First Trimester)
  static const Color trimester2 = Color(0xFF3B82F6); // Blue (Second Trimester)
  static const Color trimester3 = Color(0xFFF59E0B); // Orange (Third Trimester)

  // ── Status Colors ───────────────────────────────────
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // ── BMI Category Colors ──────────────────────────────
  static const Color bmiUnderweight = Color(0xFF3B82F6); // Blue
  static const Color bmiNormal = Color(0xFF10B981); // Green
  static const Color bmiOverweight = Color(0xFFF59E0B); // Amber
  static const Color bmiObese = Color(0xFFEF4444); // Red

  // ── Background Colors ───────────────────────────────
  static const Color background = Color(0xFFFAFAFA); // Off-White
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceLight = Color(0xFFF3F4F6); // Light Gray

  // ── Text Colors ─────────────────────────────────────
  static const Color textPrimary = Color(0xFF1F2937); // Dark Gray
  static const Color textSecondary = Color(0xFF6B7280); // Medium Gray
  static const Color textLight = Color(0xFF9CA3AF); // Light Gray
  static const Color textWhite = Color(0xFFFFFFFF); // White

  // ── Border Colors ───────────────────────────────────
  static const Color border = Color(0xFFE5E7EB); // Light Border
  static const Color borderDark = Color(0xFFD1D5DB); // Dark Border

  // ── Special Colors ──────────────────────────────────
  static const Color cardBackground = Color(0xFFFFFBFE); // Very Light Purple
  static const Color disabledBackground = Color(0xFFF3F4F6); // Disabled Gray
  static const Color disabledText = Color(0xFFD1D5DB); // Disabled Gray Text

  // ── Gradient Colors ─────────────────────────────────
  static const LinearGradient trimester1Gradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient trimester2Gradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient trimester3Gradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Get trimester color by trimester number
  static Color getTrimesterColor(int trimester) {
    switch (trimester) {
      case 1:
        return trimester1;
      case 2:
        return trimester2;
      case 3:
        return trimester3;
      default:
        return primary;
    }
  }

  /// Get BMI category color
  static Color getBmiColor(String category) {
    switch (category) {
      case 'Underweight':
        return bmiUnderweight;
      case 'Normal':
      case 'Normal weight':
        return bmiNormal;
      case 'Overweight':
        return bmiOverweight;
      case 'Obese':
        return bmiObese;
      default:
        return bmiNormal;
    }
  }

  /// Get status color
  static Color getStatusColor(String status) {
    switch (status) {
      case 'success':
        return success;
      case 'warning':
        return warning;
      case 'error':
        return error;
      case 'info':
        return info;
      default:
        return info;
    }
  }
}
