// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'3ed98e49f51da2c21a31c5447205651ce943ba55';

/// See also [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<AppUser?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeFutureProviderRef<AppUser?>;
String _$authServiceProviderHash() =>
    r'36169c55ae05aee70e864628c54ca616be8b700b';

/// See also [AuthServiceProvider].
@ProviderFor(AuthServiceProvider)
final authServiceProviderProvider =
    AutoDisposeNotifierProvider<AuthServiceProvider, AuthService>.internal(
      AuthServiceProvider.new,
      name: r'authServiceProviderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authServiceProviderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthServiceProvider = AutoDisposeNotifier<AuthService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
