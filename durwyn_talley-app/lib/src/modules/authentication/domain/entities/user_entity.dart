class UserEntity {
  final String uid;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String subscriptionPlan;
  final String avatarUrl;
  final String emergencyMessage;
  final String emergencyPhrase;
  final bool isEmailVerified;
  final String? createdAt;
  final String? updatedAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.fullName,
    this.phoneNumber = '',
    this.subscriptionPlan = 'free',
    this.avatarUrl = '',
    this.emergencyMessage = 'Help! I am in danger. Please find my location.',
    this.emergencyPhrase = '',
    this.isEmailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  UserEntity copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? subscriptionPlan,
    String? avatarUrl,
    String? emergencyMessage,
    String? emergencyPhrase,
    bool? isEmailVerified,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      emergencyMessage: emergencyMessage ?? this.emergencyMessage,
      emergencyPhrase: emergencyPhrase ?? this.emergencyPhrase,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
