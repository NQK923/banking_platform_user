// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionDetailHash() => r'40f3a4afe25717665f96a1c8110fd0a13a1aa7d3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [transactionDetail].
@ProviderFor(transactionDetail)
const transactionDetailProvider = TransactionDetailFamily();

/// See also [transactionDetail].
class TransactionDetailFamily extends Family<AsyncValue<WalletTransaction>> {
  /// See also [transactionDetail].
  const TransactionDetailFamily();

  /// See also [transactionDetail].
  TransactionDetailProvider call(String id) {
    return TransactionDetailProvider(id);
  }

  @override
  TransactionDetailProvider getProviderOverride(
    covariant TransactionDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'transactionDetailProvider';
}

/// See also [transactionDetail].
class TransactionDetailProvider
    extends AutoDisposeFutureProvider<WalletTransaction> {
  /// See also [transactionDetail].
  TransactionDetailProvider(String id)
    : this._internal(
        (ref) => transactionDetail(ref as TransactionDetailRef, id),
        from: transactionDetailProvider,
        name: r'transactionDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$transactionDetailHash,
        dependencies: TransactionDetailFamily._dependencies,
        allTransitiveDependencies:
            TransactionDetailFamily._allTransitiveDependencies,
        id: id,
      );

  TransactionDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<WalletTransaction> Function(TransactionDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionDetailProvider._internal(
        (ref) => create(ref as TransactionDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<WalletTransaction> createElement() {
    return _TransactionDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionDetailRef on AutoDisposeFutureProviderRef<WalletTransaction> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TransactionDetailProviderElement
    extends AutoDisposeFutureProviderElement<WalletTransaction>
    with TransactionDetailRef {
  _TransactionDetailProviderElement(super.provider);

  @override
  String get id => (origin as TransactionDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
