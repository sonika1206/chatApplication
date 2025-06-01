import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';
@JsonSerializable()
class AppUser {
  final String id;
  final String email;
  final String? username;
  final String? profilePhotoUrl;
  final String? bio; 

  const AppUser({
    required this.id,
    required this.email,
    this.username,
    this.profilePhotoUrl,
    this.bio,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
