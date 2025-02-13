class UserModel {
  final String accessToken;
  final String username;
  final String email;

  UserModel({
    required this.accessToken,
    required this.username,
    required this.email
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      accessToken: json['access_token'] ?? 'No Token',
      username: json['user']['identities'][0]['identity_data']['username'] ?? 'No Name',
      email: json['user']['email'] ?? 'No Email',
    );
  }
}