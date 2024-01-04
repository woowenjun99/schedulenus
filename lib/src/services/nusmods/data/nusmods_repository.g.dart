// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nusmods_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nusmodsRepositoryHash() => r'0784f9e03fcbbdc0e0e72f07e48106ee0ff11a5a';

/// See also [nusmodsRepository].
@ProviderFor(nusmodsRepository)
final nusmodsRepositoryProvider =
    AutoDisposeProvider<NusmodsRepository>.internal(
  nusmodsRepository,
  name: r'nusmodsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nusmodsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NusmodsRepositoryRef = AutoDisposeProviderRef<NusmodsRepository>;
String _$getIndividualModuleHash() =>
    r'cd584f1cd613f5d5aab248e1cc7f7c88ddb983de';

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

/// See also [getIndividualModule].
@ProviderFor(getIndividualModule)
const getIndividualModuleProvider = GetIndividualModuleFamily();

/// See also [getIndividualModule].
class GetIndividualModuleFamily extends Family<AsyncValue<Module>> {
  /// See also [getIndividualModule].
  const GetIndividualModuleFamily();

  /// See also [getIndividualModule].
  GetIndividualModuleProvider call({
    required String moduleCode,
  }) {
    return GetIndividualModuleProvider(
      moduleCode: moduleCode,
    );
  }

  @override
  GetIndividualModuleProvider getProviderOverride(
    covariant GetIndividualModuleProvider provider,
  ) {
    return call(
      moduleCode: provider.moduleCode,
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
  String? get name => r'getIndividualModuleProvider';
}

/// See also [getIndividualModule].
class GetIndividualModuleProvider extends AutoDisposeFutureProvider<Module> {
  /// See also [getIndividualModule].
  GetIndividualModuleProvider({
    required String moduleCode,
  }) : this._internal(
          (ref) => getIndividualModule(
            ref as GetIndividualModuleRef,
            moduleCode: moduleCode,
          ),
          from: getIndividualModuleProvider,
          name: r'getIndividualModuleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getIndividualModuleHash,
          dependencies: GetIndividualModuleFamily._dependencies,
          allTransitiveDependencies:
              GetIndividualModuleFamily._allTransitiveDependencies,
          moduleCode: moduleCode,
        );

  GetIndividualModuleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.moduleCode,
  }) : super.internal();

  final String moduleCode;

  @override
  Override overrideWith(
    FutureOr<Module> Function(GetIndividualModuleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetIndividualModuleProvider._internal(
        (ref) => create(ref as GetIndividualModuleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        moduleCode: moduleCode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Module> createElement() {
    return _GetIndividualModuleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetIndividualModuleProvider &&
        other.moduleCode == moduleCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, moduleCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetIndividualModuleRef on AutoDisposeFutureProviderRef<Module> {
  /// The parameter `moduleCode` of this provider.
  String get moduleCode;
}

class _GetIndividualModuleProviderElement
    extends AutoDisposeFutureProviderElement<Module>
    with GetIndividualModuleRef {
  _GetIndividualModuleProviderElement(super.provider);

  @override
  String get moduleCode => (origin as GetIndividualModuleProvider).moduleCode;
}

String _$getAllModulesHash() => r'9635490bf0e88aa8720b6c3cc6088d6058ade183';

/// See also [getAllModules].
@ProviderFor(getAllModules)
final getAllModulesProvider = AutoDisposeFutureProvider<List<Module>>.internal(
  getAllModules,
  name: r'getAllModulesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllModulesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllModulesRef = AutoDisposeFutureProviderRef<List<Module>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
