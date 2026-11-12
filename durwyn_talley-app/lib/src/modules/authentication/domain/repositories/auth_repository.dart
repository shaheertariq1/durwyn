import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<({UserEntity user, String token})> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String subscriptionPlan = 'free',
  });

  Future<({UserEntity user, String token})> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> getMe();

  Future<UserEntity> updatePlan({
    required String uid,
    required String subscriptionPlan,
  });

  Future<UserEntity> updateEmergencySettings({
    required String uid,
    String? emergencyPhrase,
    String? emergencyMessage,
  });

  Future<UserEntity> updateProfile({
    required String uid,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  });

  Future<void> signOut();

  Future<UserEntity?> getCachedUser();

  Future<String?> getCachedToken();

  Future<Map<String, dynamic>> sendPhoneCode({
    required String phoneNumber,
    String? token,
  });

  Future<Map<String, dynamic>> verifyPhoneCode({
    required String phoneNumber,
    required String code,
    String? sessionId,
    String? token,
  });

  Future<Map<String, dynamic>> resendPhoneCode({
    required String phoneNumber,
    String? token,
  });
}
