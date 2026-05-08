import 'package:flutter/material.dart';
import 'package:prenatal_care_app/core/constants/app_colors.dart';

/// BMI Category Display Widget
class BmiDisplay extends StatelessWidget {
  final double bmi;
  final String category;
  final bool showChart;

  const BmiDisplay({
    Key? key,
    required this.bmi,
    required this.category,
    this.showChart = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getBmiColor(category);
    final percentage = _getPercentage();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BMI',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    border: Border.all(color: color),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              bmi.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: color,
                  ),
            ),
            const SizedBox(height: 12),
            if (showChart) _buildBmiChart(context, percentage),
          ],
        ),
      ),
    );
  }

  double _getPercentage() {
    if (bmi < 18.5) {
      return 0.15;
    } else if (bmi < 25.0) {
      return 0.35;
    } else if (bmi < 30.0) {
      return 0.65;
    } else {
      return 0.95;
    }
  }

  Widget _buildBmiChart(BuildContext context, double percentage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: percentage,
        minHeight: 8,
        backgroundColor: AppColors.border,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.getBmiColor(category),
        ),
      ),
    );
  }
}
