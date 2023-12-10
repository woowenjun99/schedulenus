// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userRepositoryHash() => r'444853f9e066f8c6b445aef8895b9b7d38233c69';

/// See also [userRepository].
@ProviderFor(userRepository)
final userRepositoryProvider = AutoDisposeProvider<UserRepository>.internal(
  userRepository,
  name: r'userRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRepositoryRef = AutoDisposeProviderRef<UserRepository>;
String _$getUserInformationHash() =>
    r'0d58fe5dc134fd750eca0e63239b283db689f290';

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

/// See also [getUserInformation].
@ProviderFor(getUserInformation)
const getUserInformationProvider = GetUserInformationFamily();

/// See also [getUserInformation].
class GetUserInformationFamily extends Family<AsyncValue<HttpsCallableResult>> {
  /// See also [getUserInformation].
  const GetUserInformationFamily();

  /// See also [getUserInformation].
  GetUserInformationProvider call({
    required String uid,
  }) {
    return GetUserInformationProvider(
      uid: uid,
    );
  }

  @override
  GetUserInformationProvider getProviderOverride(
    covariant GetUserInformationProvider provider,
  ) {
    return call(
      uid: provider.uid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUserInformationProvider';
}

/// See also [getUserInformation].
class GetUserInformationProvider
    extends AutoDisposeFutureProvider<HttpsCallableResult> {
  /// See also [getUserInformation].
  GetUserInformationProvider({
    required String uid,
  }) : this._internal(
          (ref) => getUserInformation(
            ref as GetUserInformationRef,
            uid: uid,
          ),
          from: getUserInformationProvider,
          name: r'getUserInformationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserInformationHash,
          dependencies: GetUserInformationFamily._dependencies,
          allTransitiveDependencies:
              GetUserInformationFamily._allTransitiveDependencies,
          uid: uid,
        );

  GetUserInformationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<HttpsCallableResult> Function(GetUserInformationRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetUserInformationProvider._internal(
        (ref) => create(ref as GetUserInformationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HttpsCallableResult> createElement() {
    return _GetUserInformationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetUserInformationProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetUserInformationRef
    on AutoDisposeFutureProviderRef<HttpsCallableResult> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _GetUserInformationProviderElement
    extends AutoDisposeFutureProviderElement<HttpsCallableResult>
    with GetUserInformationRef {
  _GetUserInformationProviderElement(super.provider);

  @override
  String get uid => (origin as GetUserInformationProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
