// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatServiceHash() => r'b6ce1ae2c79dedf772fc2b823ff758495c81c766';

/// See also [chatService].
@ProviderFor(chatService)
final chatServiceProvider = AutoDisposeProvider<ChatService>.internal(
  chatService,
  name: r'chatServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatServiceRef = AutoDisposeProviderRef<ChatService>;
String _$userServiceHash() => r'bfe9b78e5d3b986672fe3b0277c158c5ec46b6a3';

/// See also [userService].
@ProviderFor(userService)
final userServiceProvider = AutoDisposeProvider<UserService>.internal(
  userService,
  name: r'userServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserServiceRef = AutoDisposeProviderRef<UserService>;
String _$userChatsHash() => r'f47031d2473f08c6d1aff18a2e9efa6af7839f8b';

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

/// See also [userChats].
@ProviderFor(userChats)
const userChatsProvider = UserChatsFamily();

/// See also [userChats].
class UserChatsFamily extends Family<AsyncValue<List<Chat>>> {
  /// See also [userChats].
  const UserChatsFamily();

  /// See also [userChats].
  UserChatsProvider call(String userId) {
    return UserChatsProvider(userId);
  }

  @override
  UserChatsProvider getProviderOverride(covariant UserChatsProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userChatsProvider';
}

/// See also [userChats].
class UserChatsProvider extends AutoDisposeStreamProvider<List<Chat>> {
  /// See also [userChats].
  UserChatsProvider(String userId)
    : this._internal(
        (ref) => userChats(ref as UserChatsRef, userId),
        from: userChatsProvider,
        name: r'userChatsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userChatsHash,
        dependencies: UserChatsFamily._dependencies,
        allTransitiveDependencies: UserChatsFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserChatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<List<Chat>> Function(UserChatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserChatsProvider._internal(
        (ref) => create(ref as UserChatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Chat>> createElement() {
    return _UserChatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserChatsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserChatsRef on AutoDisposeStreamProviderRef<List<Chat>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserChatsProviderElement
    extends AutoDisposeStreamProviderElement<List<Chat>>
    with UserChatsRef {
  _UserChatsProviderElement(super.provider);

  @override
  String get userId => (origin as UserChatsProvider).userId;
}

String _$messagesHash() => r'b5ee55e5b2c4a5d708940d735f057f02e49294d7';

/// See also [messages].
@ProviderFor(messages)
const messagesProvider = MessagesFamily();

/// See also [messages].
class MessagesFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [messages].
  const MessagesFamily();

  /// See also [messages].
  MessagesProvider call(String chatId) {
    return MessagesProvider(chatId);
  }

  @override
  MessagesProvider getProviderOverride(covariant MessagesProvider provider) {
    return call(provider.chatId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesProvider';
}

/// See also [messages].
class MessagesProvider extends AutoDisposeStreamProvider<List<Message>> {
  /// See also [messages].
  MessagesProvider(String chatId)
    : this._internal(
        (ref) => messages(ref as MessagesRef, chatId),
        from: messagesProvider,
        name: r'messagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$messagesHash,
        dependencies: MessagesFamily._dependencies,
        allTransitiveDependencies: MessagesFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  MessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Override overrideWith(
    Stream<List<Message>> Function(MessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessagesProvider._internal(
        (ref) => create(ref as MessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Message>> createElement() {
    return _MessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessagesRef on AutoDisposeStreamProviderRef<List<Message>> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _MessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<Message>>
    with MessagesRef {
  _MessagesProviderElement(super.provider);

  @override
  String get chatId => (origin as MessagesProvider).chatId;
}

String _$allUsersHash() => r'bc0e24ac39cdef1463cbe7b28ca82600dd196c68';

/// See also [allUsers].
@ProviderFor(allUsers)
final allUsersProvider =
    AutoDisposeStreamProvider<List<Map<String, dynamic>>>.internal(
      allUsers,
      name: r'allUsersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allUsersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllUsersRef = AutoDisposeStreamProviderRef<List<Map<String, dynamic>>>;
String _$usernameByIdHash() => r'c0b7b26f1cb345096d0d3804b3c01d58d0b9aa1f';

/// See also [usernameById].
@ProviderFor(usernameById)
const usernameByIdProvider = UsernameByIdFamily();

/// See also [usernameById].
class UsernameByIdFamily extends Family<AsyncValue<UserDetails?>> {
  /// See also [usernameById].
  const UsernameByIdFamily();

  /// See also [usernameById].
  UsernameByIdProvider call(String userId) {
    return UsernameByIdProvider(userId);
  }

  @override
  UsernameByIdProvider getProviderOverride(
    covariant UsernameByIdProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'usernameByIdProvider';
}

/// See also [usernameById].
class UsernameByIdProvider extends AutoDisposeFutureProvider<UserDetails?> {
  /// See also [usernameById].
  UsernameByIdProvider(String userId)
    : this._internal(
        (ref) => usernameById(ref as UsernameByIdRef, userId),
        from: usernameByIdProvider,
        name: r'usernameByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$usernameByIdHash,
        dependencies: UsernameByIdFamily._dependencies,
        allTransitiveDependencies:
            UsernameByIdFamily._allTransitiveDependencies,
        userId: userId,
      );

  UsernameByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<UserDetails?> Function(UsernameByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UsernameByIdProvider._internal(
        (ref) => create(ref as UsernameByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserDetails?> createElement() {
    return _UsernameByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UsernameByIdProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UsernameByIdRef on AutoDisposeFutureProviderRef<UserDetails?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UsernameByIdProviderElement
    extends AutoDisposeFutureProviderElement<UserDetails?>
    with UsernameByIdRef {
  _UsernameByIdProviderElement(super.provider);

  @override
  String get userId => (origin as UsernameByIdProvider).userId;
}

String _$createGroupChatHash() => r'79af76a93b2873bb0db28cfddd587c85f7112bbc';

/// See also [createGroupChat].
@ProviderFor(createGroupChat)
const createGroupChatProvider = CreateGroupChatFamily();

/// See also [createGroupChat].
class CreateGroupChatFamily extends Family<AsyncValue<String>> {
  /// See also [createGroupChat].
  const CreateGroupChatFamily();

  /// See also [createGroupChat].
  CreateGroupChatProvider call(
    String groupName,
    List<String> participantIds,
    String currentUserId,
  ) {
    return CreateGroupChatProvider(groupName, participantIds, currentUserId);
  }

  @override
  CreateGroupChatProvider getProviderOverride(
    covariant CreateGroupChatProvider provider,
  ) {
    return call(
      provider.groupName,
      provider.participantIds,
      provider.currentUserId,
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
  String? get name => r'createGroupChatProvider';
}

/// See also [createGroupChat].
class CreateGroupChatProvider extends AutoDisposeFutureProvider<String> {
  /// See also [createGroupChat].
  CreateGroupChatProvider(
    String groupName,
    List<String> participantIds,
    String currentUserId,
  ) : this._internal(
        (ref) => createGroupChat(
          ref as CreateGroupChatRef,
          groupName,
          participantIds,
          currentUserId,
        ),
        from: createGroupChatProvider,
        name: r'createGroupChatProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createGroupChatHash,
        dependencies: CreateGroupChatFamily._dependencies,
        allTransitiveDependencies:
            CreateGroupChatFamily._allTransitiveDependencies,
        groupName: groupName,
        participantIds: participantIds,
        currentUserId: currentUserId,
      );

  CreateGroupChatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupName,
    required this.participantIds,
    required this.currentUserId,
  }) : super.internal();

  final String groupName;
  final List<String> participantIds;
  final String currentUserId;

  @override
  Override overrideWith(
    FutureOr<String> Function(CreateGroupChatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateGroupChatProvider._internal(
        (ref) => create(ref as CreateGroupChatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupName: groupName,
        participantIds: participantIds,
        currentUserId: currentUserId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _CreateGroupChatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateGroupChatProvider &&
        other.groupName == groupName &&
        other.participantIds == participantIds &&
        other.currentUserId == currentUserId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupName.hashCode);
    hash = _SystemHash.combine(hash, participantIds.hashCode);
    hash = _SystemHash.combine(hash, currentUserId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateGroupChatRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `groupName` of this provider.
  String get groupName;

  /// The parameter `participantIds` of this provider.
  List<String> get participantIds;

  /// The parameter `currentUserId` of this provider.
  String get currentUserId;
}

class _CreateGroupChatProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with CreateGroupChatRef {
  _CreateGroupChatProviderElement(super.provider);

  @override
  String get groupName => (origin as CreateGroupChatProvider).groupName;
  @override
  List<String> get participantIds =>
      (origin as CreateGroupChatProvider).participantIds;
  @override
  String get currentUserId => (origin as CreateGroupChatProvider).currentUserId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
