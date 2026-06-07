import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../history/domain/wallet_transaction.dart'; // import DecimalConverter

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

@freezed
class BalanceResponse with _$BalanceResponse {
  const factory BalanceResponse({
    required String accountId,
    @DecimalConverter() required Decimal balance,
    required String currency,
  }) = _BalanceResponse;

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);
}

@freezed
class MovementResponse with _$MovementResponse {
  const factory MovementResponse({
    required String journalId,
    required BalanceResponse balance,
  }) = _MovementResponse;

  factory MovementResponse.fromJson(Map<String, dynamic> json) =>
      _$MovementResponseFromJson(json);
}
