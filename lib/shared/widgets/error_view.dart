import 'package:flutter/material.dart';
import '../../core/error/app_exception.dart';
import '../../core/theme/app_theme.dart';
import 'app_card.dart';

class ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;
  final bool inline;

  const ErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.inline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appException = AppException.unknown(error);
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: inline ? 48 : 64,
          height: inline ? 48 : 64,
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.warning_amber_rounded,
            color: theme.colorScheme.onErrorContainer,
            size: inline ? 26 : 34,
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        Text(
          appException.userFriendlyMessage,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Code: ${appException.code}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (appException.traceId != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Trace: ${appException.traceId}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.l),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ],
    );

    if (inline) {
      return AppCard(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.26),
        child: content,
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: AppCard(child: content),
      ),
    );
  }
}
