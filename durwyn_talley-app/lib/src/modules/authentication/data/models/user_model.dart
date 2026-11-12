import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.phoneNumber = '',
    super.subscriptionPlan = 'free',
    super.avatarUrl = '',
    super.emergencyMessage = 'Help! I am in danger. Please find my location.',
    super.emergencyPhrase = '',
    super.isEmailVerified = false,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? json['fullName'] ?? '',
      phoneNumber: json['phone_number'] ?? json['phoneNumber'] ?? '',
      subscriptionPlan: json['subscription_plan'] ?? json['subscriptionPlan'] ?? 'free',
      avatarUrl: json['avatar_url'] ?? json['avatarUrl'] ?? '',
      emergencyMessage: json['emergency_message'] ??
          json['emergencyMessage'] ??
          'Help! I am in danger. Please find my location.',
      emergencyPhrase: json['emergency_phrase'] ?? json['emergencyPhrase'] ?? '',
      isEmailVerified: json['is_email_verified'] ?? json['isEmailVerified'] ?? false,
      createdAt: json['created_at'] ?? json['createdAt'],
      updatedAt: json['updated_at'] ?? json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'subscription_plan': subscriptionPlan,
      'avatar_url': avatarUrl,
      'emergency_message': emergencyMessage,
      'emergency_phrase': emergencyPhrase,
      'is_email_verified': isEmailVerified,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      subscriptionPlan: entity.subscriptionPlan,
      avatarUrl: entity.avatarUrl,
      emergencyMessage: entity.emergencyMessage,
      emergencyPhrase: entity.emergencyPhrase,
      isEmailVerified: entity.isEmailVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
