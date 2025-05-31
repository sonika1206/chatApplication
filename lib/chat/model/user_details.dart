class UserDetails {
  final String? username;
  final String? profilePhotoUrl;

  UserDetails({
    this.username,
    this.profilePhotoUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      username: json['username'] as String?,
      profilePhotoUrl: json['profile_photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profile_photo_url': profilePhotoUrl,
    };
  }
}