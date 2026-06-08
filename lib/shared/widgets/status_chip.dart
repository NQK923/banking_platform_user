import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({super.key, required this.status});

  Color _getStatusColor(String statusValue, ColorScheme colors) {
    switch (statusValue.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'COMPENSATING':
        return Colors.purple;
      case 'FAILED':
      case 'CANCELLED':
        return colors.error;
      default:
        return colors.onSurface.withOpacity(0.5);
    }
  }

  String _getStatusText(String statusValue) {
    switch (statusValue.toUpperCase()) {
      case 'COMPLETED':
        return 'Thành công';
      case 'PENDING':
        return 'Đang xử lý';
      case 'COMPENSATING':
        return 'Đang hoàn tiền';
      case 'FAILED':
        return 'Thất bại';
      case 'CANCELLED':
        return 'Đã hủy';
      default:
        return statusValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(status, theme.colorScheme);
    final text = _getStatusText(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
