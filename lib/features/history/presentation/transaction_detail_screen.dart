import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/amount_text.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../auth/domain/auth_notifier.dart';
import '../../auth/domain/auth_state.dart';
import '../domain/detail_provider.dart';
import '../domain/wallet_transaction.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã sao chép $label'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);
    final detailState = ref.watch(transactionDetailProvider(transactionId));

    String currentUserAccountId = '';
    if (authState is AuthStateAuthenticated) {
      currentUserAccountId = authState.accountId ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết giao dịch'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => ErrorView(
          error: err,
          onRetry: () => ref.refresh(transactionDetailProvider(transactionId)),
        ),
        data: (tx) {
          final isDebit = tx.senderId == currentUserAccountId;
          final txIcon = isDebit ? Icons.arrow_outward : Icons.arrow_downward;
          final iconColor = isDebit ? theme.colorScheme.error : Colors.green;

          // Compute failure description
          final failureText = tx.status == TransactionStatus.FAILED
              ? (tx.failureReason ?? _getFailureMessage(tx.idempotencyKey))
              : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header details
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: iconColor.withOpacity(0.08),
                        child: Icon(txIcon, color: iconColor, size: 36),
                      ),
                      const SizedBox(height: AppSpacing.m),
                      Text(
                        isDebit
                            ? 'Chuyển tiền thành công'
                            : 'Nhận tiền thành công',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(
                            0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      AmountText.forTransaction(
                        transaction: tx,
                        currentUserAccountId: currentUserAccountId,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s),
                      StatusChip(status: tx.status.name),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Failure Reason Box
                if (failureText != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(AppRadius.m),
                      border: Border.all(
                        color: theme.colorScheme.error.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: theme.colorScheme.error,
                            ),
                            const SizedBox(width: AppSpacing.s),
                            Text(
                              'Lỗi giao dịch',
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s),
                        Text(
                          failureText,
                          style: TextStyle(
                            color: theme.colorScheme.error.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                ],

                // Information details card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin chi tiết',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.m),
                        _buildDetailRow(
                          context: context,
                          label: 'Mã giao dịch (ID)',
                          value: tx.id,
                          isCopyable: true,
                        ),
                        _buildDetailRow(
                          context: context,
                          label: 'Tài khoản gửi',
                          value: tx.senderId,
                          subValue: tx.senderId == currentUserAccountId
                              ? '(Ví của bạn)'
                              : null,
                          isCopyable: true,
                        ),
                        _buildDetailRow(
                          context: context,
                          label: 'Tài khoản nhận',
                          value: tx.receiverId,
                          subValue: tx.receiverId == currentUserAccountId
                              ? '(Ví của bạn)'
                              : null,
                          isCopyable: true,
                        ),
                        _buildDetailRow(
                          context: context,
                          label: 'Thời gian tạo',
                          value: _formatDateTime(tx.createdAt),
                        ),
                        _buildDetailRow(
                          context: context,
                          label: 'Cập nhật lần cuối',
                          value: _formatDateTime(tx.updatedAt),
                        ),
                        _buildDetailRow(
                          context: context,
                          label: 'Khóa đối sánh (Idempotency)',
                          value: tx.idempotencyKey,
                          isCopyable: true,
                        ),
                        if (tx.correlationId != null)
                          _buildDetailRow(
                            context: context,
                            label: 'Trace ID (Correlation ID)',
                            value: tx.correlationId!,
                            isCopyable: true,
                          ),
                        _buildDetailRow(
                          context: context,
                          label: 'Lời nhắn',
                          value: tx.note ?? 'Giao dịch chuyển khoản E-Wallet',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow({
    required BuildContext context,
    required String label,
    required String value,
    String? subValue,
    bool isCopyable = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isCopyable
                        ? FontWeight.w500
                        : FontWeight.normal,
                    fontFamily: isCopyable ? 'monospace' : null,
                  ),
                ),
              ),
              if (isCopyable) ...[
                const SizedBox(width: AppSpacing.s),
                GestureDetector(
                  onTap: () => _copyToClipboard(context, value, label),
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ],
          ),
          if (subValue != null) ...[
            const SizedBox(height: 1),
            Text(
              subValue,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDateTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} - ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return isoString;
    }
  }

  String _getFailureMessage(String key) {
    // Generate simple failures if needed for stubs
    return 'Lỗi xử lý Saga: Giao dịch không thể hoàn tất. Tài khoản nhận không hoạt động hoặc số dư tài khoản gửi không đủ để hoàn thành giao dịch.';
  }
}
