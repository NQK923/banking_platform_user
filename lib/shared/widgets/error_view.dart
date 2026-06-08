import 'package:flutter/material.dart';
import '../../core/error/app_exception.dart';
import '../../core/theme/app_theme.dart';

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
    final displayMsg = appException.userFriendlyMessage;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline_outlined,
          color: theme.colorScheme.error,
          size: inline ? 36 : 48,
        ),
        const SizedBox(height: AppSpacing.s),
        Text(
          displayMsg,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Mã lỗi: ${appException.code}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        if (appException.traceId != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Trace ID: ${appException.traceId}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              fontSize: 10,
              color: theme.colorScheme.onSurface.withOpacity(0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.m),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ],
    );

    if (inline) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.m),
          border: Border.all(color: theme.colorScheme.error.withOpacity(0.2)),
        ),
        child: content,
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: content,
          ),
        ),
      ),
    );
  }
}
