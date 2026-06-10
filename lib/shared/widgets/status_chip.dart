import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  _StatusStyle _style(String raw, ColorScheme colors) {
    switch (raw.toUpperCase()) {
      case 'COMPLETED':
        return const _StatusStyle(
          'Completed',
          Icons.check_circle,
          AppTheme.success,
        );
      case 'PENDING':
        return const _StatusStyle('Pending', Icons.schedule, AppTheme.warning);
      case 'PROCESSING':
        return const _StatusStyle('Processing', Icons.sync, AppTheme.info);
      case 'COMPENSATING':
        return const _StatusStyle(
          'Refunding',
          Icons.replay_circle_filled,
          AppTheme.violet,
        );
      case 'FAILED':
        return _StatusStyle('Failed', Icons.error, colors.error);
      case 'CANCELLED':
        return _StatusStyle('Cancelled', Icons.block, colors.outline);
      default:
        return _StatusStyle(raw, Icons.help_outline, colors.onSurfaceVariant);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = _style(status, theme.colorScheme);

    return Semantics(
      label: 'Transaction status ${style.label}',
      child: Container(
        constraints: const BoxConstraints(minHeight: 28),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: style.color.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.20 : 0.12,
          ),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: style.color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(style.icon, size: 14, color: style.color),
            const SizedBox(width: 5),
            Text(
              style.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: style.color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusStyle {
  final String label;
  final IconData icon;
  final Color color;

  const _StatusStyle(this.label, this.icon, this.color);
}
