import '../../../../core/utils/app_exports.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String subscriptionPlan = 'free',
  });

  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> getMe({required String token});

  Future<UserModel> updatePlan({
    required String uid,
    required String subscriptionPlan,
    String? token,
  });

  Future<UserModel> updateEmergencySettings({
    required String uid,
    String? emergencyPhrase,
    String? emergencyMessage,
    String? token,
  });

  Future<UserModel> updateProfile({
    required String uid,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    String? token,
  });

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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final BaseApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  Map<String, String> _headers([String? token]) {
    final map = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      map['Authorization'] = 'Bearer $token';
    }
    return map;
  }

  @override
  Future<AuthResponseModel> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    String subscriptionPlan = 'free',
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.signup),
      headers: _headers(),
      body: {
        'email': email.trim(),
        'password': password,
        'full_name': fullName.trim(),
        'phone_number': phoneNumber?.trim() ?? '',
        'subscription_plan': subscriptionPlan,
      },
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.signin),
      headers: _headers(),
      body: {
        'email': email.trim(),
        'password': password,
      },
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<UserModel> getMe({required String token}) async {
    final response = await _apiService.requestGET(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.me),
      headers: _headers(token),
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updatePlan({
    required String uid,
    required String subscriptionPlan,
    String? token,
  }) async {
    final response = await _apiService.requestPUT(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.userPlan(uid)),
      headers: _headers(token),
      body: {'subscription_plan': subscriptionPlan},
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updateEmergencySettings({
    required String uid,
    String? emergencyPhrase,
    String? emergencyMessage,
    String? token,
  }) async {
    final payload = <String, dynamic>{};
    if (emergencyPhrase != null) payload['emergency_phrase'] = emergencyPhrase;
    if (emergencyMessage != null) payload['emergency_message'] = emergencyMessage;

    final response = await _apiService.requestPUT(
      apiRoute:
          ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.userEmergency(uid)),
      headers: _headers(token),
      body: payload,
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updateProfile({
    required String uid,
    String? fullName,
    String? phoneNumber,
    String? avatarUrl,
    String? token,
  }) async {
    final payload = <String, dynamic>{};
    if (fullName != null) payload['full_name'] = fullName;
    if (phoneNumber != null) payload['phone_number'] = phoneNumber;
    if (avatarUrl != null) payload['avatar_url'] = avatarUrl;

    final response = await _apiService.requestPUT(
      apiRoute:
          ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.userProfile(uid)),
      headers: _headers(token),
      body: payload,
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return UserModel.fromJson(data);
  }

  @override
  Future<Map<String, dynamic>> sendPhoneCode({
    required String phoneNumber,
    String? token,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.phoneSendCode),
      headers: _headers(token),
      body: {'phone_number': phoneNumber.trim()},
    );
    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return data;
  }

  @override
  Future<Map<String, dynamic>> verifyPhoneCode({
    required String phoneNumber,
    required String code,
    String? sessionId,
    String? token,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.phoneVerifyCode),
      headers: _headers(token),
      body: {
        'phone_number': phoneNumber.trim(),
        'code': code.trim(),
        'session_id': sessionId,
      },
    );
    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return data;
  }

  @override
  Future<Map<String, dynamic>> resendPhoneCode({
    required String phoneNumber,
    String? token,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.phoneResendCode),
      headers: _headers(token),
      body: {'phone_number': phoneNumber.trim()},
    );
    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return data;
  }
}
