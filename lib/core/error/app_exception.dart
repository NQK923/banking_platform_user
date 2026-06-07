import 'package:dio/dio.dart';

class AppException implements Exception {
  final String code;
  final String message;
  final String? traceId;

  const AppException({
    required this.code,
    required this.message,
    this.traceId,
  });

  @override
  String toString() => 'AppException(code: $code, message: $message, traceId: $traceId)';

  // Friendly localized or user-facing message mappings
  String get userFriendlyMessage {
    switch (code) {
      case 'AUTH_EXPIRED':
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
      case 'AUTH_INVALID':
        return 'Thông tin đăng nhập không chính xác.';
      case 'RECIPIENT_NOT_FOUND':
        return 'Không tìm thấy người nhận thanh toán.';
      case 'RECIPIENT_SUSPENDED':
        return 'Tài khoản người nhận đang bị tạm khóa.';
      case 'CURRENCY_MISMATCH':
        return 'Không hỗ trợ chuyển tiền khác loại tiền tệ.';
      case 'INSUFFICIENT_FUNDS':
        return 'Số dư tài khoản không đủ để thực hiện giao dịch.';
      case 'PIN_INVALID':
        return 'Mã PIN giao dịch không đúng. Vui lòng thử lại.';
      case 'RATE_LIMITED':
        return 'Yêu cầu quá nhanh. Vui lòng thử lại sau ít phút.';
      case 'NETWORK_ERROR':
        return 'Lỗi kết nối mạng. Vui lòng kiểm tra lại đường truyền.';
      case 'TIMEOUT_ERROR':
        return 'Kết nối mạng quá hạn. Vui lòng thử lại.';
      case 'INTERNAL':
      default:
        return message.isNotEmpty ? message : 'Đã có lỗi xảy ra. Vui lòng thử lại sau.';
    }
  }

  factory AppException.fromDioException(DioException dioException) {
    if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.sendTimeout ||
        dioException.type == DioExceptionType.receiveTimeout) {
      return const AppException(
        code: 'TIMEOUT_ERROR',
        message: 'Request timed out. Please try again.',
      );
    }

    if (dioException.type == DioExceptionType.connectionError ||
        dioException.type == DioExceptionType.badCertificate) {
      return const AppException(
        code: 'NETWORK_ERROR',
        message: 'Cannot connect to server. Check your internet connection.',
      );
    }

    final response = dioException.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final code = data['code']?.toString() ?? 'INTERNAL';
      final message = data['message']?.toString() ?? 'An error occurred';
      final traceId = data['traceId']?.toString();
      return AppException(code: code, message: message, traceId: traceId);
    }

    return AppException(
      code: 'NETWORK_ERROR',
      message: dioException.message ?? 'Unknown connection error occurred',
    );
  }

  factory AppException.unknown(dynamic error) {
    if (error is AppException) return error;
    if (error is DioException) return AppException.fromDioException(error);
    return AppException(
      code: 'INTERNAL',
      message: error.toString(),
    );
  }
}
