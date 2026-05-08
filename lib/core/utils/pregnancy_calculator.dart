import 'package:intl/intl.dart';

/// Utility class for pregnancy-related calculations
class PregnancyCalculator {
  /// Calculate gestational age from LMP (Last Menstrual Period)
  static Map<String, int> gestationalAge(DateTime lmp) {
    final days = DateTime.now().difference(lmp).inDays;
    return {
      'weeks': days ~/ 7,
      'days': days % 7,
      'totalDays': days,
    };
  }

  /// Calculate EDD using Naegele's Rule: LMP + 280 days (40 weeks)
  static DateTime estimatedDueDate(DateTime lmp) {
    return lmp.add(const Duration(days: 280));
  }

  /// Calculate BMI
  static double calculateBmi(double weightKg, double heightM) {
    if (heightM == 0) return 0;
    return weightKg / (heightM * heightM);
  }

  /// Get BMI category
  static String getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal weight';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  /// Get trimester based on weeks
  static int getTrimester(int weeks) {
    if (weeks <= 13) return 1;
    if (weeks <= 26) return 2;
    return 3;
  }

  /// Get weight gain recommendation based on BMI
  static String getWeightGainAdvice(double bmi) {
    if (bmi < 18.5) return 'Recommended gain: 12.5–18 kg';
    if (bmi < 25.0) return 'Recommended gain: 11.5–16 kg';
    if (bmi < 30.0) return 'Recommended gain: 7–11.5 kg';
    return 'Recommended gain: 5–9 kg (consult doctor)';
  }

  /// Calculate pregnancy progress percentage (0-100)
  static double getPregnancyProgress(DateTime lmp) {
    const totalDays = 280; // 40 weeks
    final days = DateTime.now().difference(lmp).inDays;
    if (days >= totalDays) return 100.0;
    return (days / totalDays) * 100;
  }

  /// Get days remaining until EDD
  static int daysUntilEdd(DateTime edd) {
    final daysRemaining = edd.difference(DateTime.now()).inDays;
    return daysRemaining > 0 ? daysRemaining : 0;
  }

  /// Format gestational age as "Xw + Yd"
  static String formatGestationalAge(int weeks, int days) {
    return '$weeks weeks + $days days';
  }

  /// Format date to readable format
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Check if current week matches visit week
  static bool isVisitWeek(int currentWeek, int visitWeek) {
    return currentWeek >= visitWeek && currentWeek < visitWeek + 4;
  }
}
