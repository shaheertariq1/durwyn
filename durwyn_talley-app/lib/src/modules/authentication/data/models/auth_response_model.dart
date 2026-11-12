import 'user_model.dart';

class AuthResponseModel {
  final String accessToken;
  final String tokenType;
  final UserModel user;

  const AuthResponseModel({
    required this.accessToken,
    this.tokenType = 'bearer',
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'bearer',
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
