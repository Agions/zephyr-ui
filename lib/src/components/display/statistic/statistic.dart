import 'package:flutter/material.dart';

class ZephyrStatistic extends StatelessWidget {
  const ZephyrStatistic({
    required this.title,
    required this.value,
    super.key,
    this.suffix,
    this.prefix,
    this.description,
    this.trend,
    this.color,
  });

  final String title;
  final String value;
  final String? suffix;
  final String? prefix;
  final String? description;
  final String? trend;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha:0.7),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (prefix != null)
                  Text(
                    prefix!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: effectiveColor,
                    ),
                  ),
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: effectiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (suffix != null)
                  Text(
                    suffix!,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: effectiveColor,
                    ),
                  ),
              ],
            ),
            if (trend != null || description != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (trend != null)
                    Text(
                      trend!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            trend!.startsWith('+') ? Colors.green : Colors.red,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
