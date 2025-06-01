// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  username: json['username'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String?,
  bio: json['bio'] as String?,
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'username': instance.username,
  'profilePhotoUrl': instance.profilePhotoUrl,
  'bio': instance.bio,
};
