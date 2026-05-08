import 'package:flutter/material.dart';
import 'package:prenatal_care_app/core/constants/app_colors.dart';

/// Info Card Widget
class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const InfoCard({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor ?? AppColors.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (icon != null) ...
                [
                  Icon(
                    icon,
                    size: 32,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 16),
                ]
              else
                const SizedBox.shrink(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      value,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.primary),
                    ),
                    if (subtitle != null) ...
                      [
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ]
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
