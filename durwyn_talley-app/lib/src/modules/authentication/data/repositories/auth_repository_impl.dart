import 'dart:convert';
import '../../../../core/services/local_db_service/secure_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final Prefs _prefs;

  AuthRepositoryImpl(this._remoteDataSource, this._prefs);

  @override
  Future<({UserEntity user, String token})> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String subscriptionPlan = 'free',
  }) async {
    final result = await _remoteDataSource.signUp(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      subscriptionPlan: subscriptionPlan,
    );

    await _prefs.storeToken(result.accessToken);
    await _prefs.storeUserRaw(jsonEncode(result.user.toJson()));

    return (user: result.user, token: result.accessToken);
  }

  @override
  Future<({UserEntity user, String token})> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _remoteDataSource.signIn(
      email: email,
      password: password,
    );

    await _prefs.storeToken(result.accessToken);
    await _prefs.storeUserRaw(jsonEncode(result.user.toJson()));

    return (user: result.user, token: result.accessToken);
  }

  @override
  Future<UserEntity> getMe() async {
    final token = await _prefs.fetchToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not authenticated');
    }

    final user = await _remoteDataSource.getMe(token: token);
    await _prefs.storeUserRaw(jsonEncode(user.toJson()));
    return user;
  }

  @override
  Future<UserEntity> updatePlan({
    required String uid,
    required String subscriptionPlan,
  }) async {
    final token = await _prefs.fetchToken();
    final updated = await _remoteDataSource.updatePlan(
      uid: uid,
      subscriptionPlan: subscriptionPlan,
      token: token,
    );

    await _prefs.storeUserRaw(jsonEncode(updated.toJson()));
    return updated;
  }

  @override
  Future<UserEntity> updateEmergencySettings({
    required String uid,
    String? emergencyPhrase,
    String? emergencyMessage,
  }) async {
    final token = await _prefs.fetchToken();
    final updated = await _remoteDataSource.updateEmergencySettings(
      uid: uid,
      emergencyPhrase: emergencyPhrase,
      emergencyMessage: emergencyMessage,
      token: token,
    );

    await _prefs.storeUserRaw(jsonEncode(updated.toJson()));
    return updated;
  }

  @override
  Future<UserEntity> updateProfile({
    required String uid,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
  }) async {
    final token = await _prefs.fetchToken();
    final updated = await _remoteDataSource.updateProfile(
      uid: uid,
      fullName: fullName,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      token: token,
    );

    await _prefs.storeUserRaw(jsonEncode(updated.toJson()));
    return updated;
  }

  @override
  Future<void> signOut() async {
    await _prefs.deleteToken();
    await _prefs.deleteUser();
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final raw = await _prefs.fetchUserRaw();
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return UserModel.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> getCachedToken() async {
    try {
      return await _prefs.fetchToken();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> sendPhoneCode({
    required String phoneNumber,
    String? token,
  }) async {
    final effectiveToken = token ?? await getCachedToken();
    return await _remoteDataSource.sendPhoneCode(
      phoneNumber: phoneNumber,
      token: effectiveToken,
    );
  }

  @override
  Future<Map<String, dynamic>> verifyPhoneCode({
    required String phoneNumber,
    required String code,
    String? sessionId,
    String? token,
  }) async {
    final effectiveToken = token ?? await getCachedToken();
    return await _remoteDataSource.verifyPhoneCode(
      phoneNumber: phoneNumber,
      code: code,
      sessionId: sessionId,
      token: effectiveToken,
    );
  }

  @override
  Future<Map<String, dynamic>> resendPhoneCode({
    required String phoneNumber,
    String? token,
  }) async {
    final effectiveToken = token ?? await getCachedToken();
    return await _remoteDataSource.resendPhoneCode(
      phoneNumber: phoneNumber,
      token: effectiveToken,
    );
  }
}
