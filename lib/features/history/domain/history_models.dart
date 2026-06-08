import 'wallet_transaction.dart';

class PaginatedHistoryResponse {
  final List<WalletTransaction> items;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  PaginatedHistoryResponse({
    required this.items,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PaginatedHistoryResponse.fromJson(Map<String, dynamic> json) {
    final list =
        (json['items'] as List<dynamic>?)
            ?.map(
              (item) =>
                  WalletTransaction.fromJson(item as Map<String, dynamic>),
            )
            .toList() ??
        [];
    return PaginatedHistoryResponse(
      items: list,
      page: json['page'] as int? ?? 0,
      size: json['size'] as int? ?? 10,
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );
  }
}
