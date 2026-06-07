// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountDetailsHash() => r'af25f5cb44bf0e9658aa4b8f080a2bac5d1576f1';

/// See also [accountDetails].
@ProviderFor(accountDetails)
final accountDetailsProvider =
    AutoDisposeFutureProvider<AccountRecord>.internal(
      accountDetails,
      name: r'accountDetailsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$accountDetailsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccountDetailsRef = AutoDisposeFutureProviderRef<AccountRecord>;
String _$balanceHash() => r'dc9a857ce6f4ebdc1ebf444a2e7fde4b69776217';

/// See also [Balance].
@ProviderFor(Balance)
final balanceProvider =
    AutoDisposeAsyncNotifierProvider<Balance, BalanceResponse>.internal(
      Balance.new,
      name: r'balanceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$balanceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Balance = AutoDisposeAsyncNotifier<BalanceResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
