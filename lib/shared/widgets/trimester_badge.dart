import 'package:flutter/material.dart';
import 'package:prenatal_care_app/core/constants/app_colors.dart';
import 'package:prenatal_care_app/core/utils/pregnancy_calculator.dart';

/// Trimester Badge Widget
class TrimesterBadge extends StatelessWidget {
  final int trimester;
  final bool showLabel;

  const TrimesterBadge({
    Key? key,
    required this.trimester,
    this.showLabel = true,
  }) : super(key: key);

  String _getTrimesterText() {
    switch (trimester) {
      case 1:
        return 'First Trimester';
      case 2:
        return 'Second Trimester';
      case 3:
        return 'Third Trimester';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getTrimesterColor(trimester);
    final text = _getTrimesterText();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
