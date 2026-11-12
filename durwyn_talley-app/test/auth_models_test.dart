import 'package:flutter_test/flutter_test.dart';
import 'package:durwyn_talley/src/modules/authentication/data/models/user_model.dart';
import 'package:durwyn_talley/src/modules/authentication/data/models/auth_response_model.dart';

void main() {
  group('Authentication Models Test', () {
    test('UserModel.fromJson parses snake_case and camelCase correctly', () {
      final json = {
        'uid': 'test-uid-123',
        'email': 'user@example.com',
        'full_name': 'Test User',
        'phone_number': '+15550001111',
        'subscription_plan': 'standard',
        'avatar_url': 'https://example.com/avatar.jpg',
        'emergency_message': 'Emergency test message',
        'emergency_phrase': 'Blue Sky',
        'is_email_verified': true,
        'created_at': '2026-10-08T12:00:00Z',
        'updated_at': '2026-10-08T12:00:00Z',
      };

      final user = UserModel.fromJson(json);

      expect(user.uid, equals('test-uid-123'));
      expect(user.email, equals('user@example.com'));
      expect(user.fullName, equals('Test User'));
      expect(user.phoneNumber, equals('+15550001111'));
      expect(user.subscriptionPlan, equals('standard'));
      expect(user.emergencyPhrase, equals('Blue Sky'));
      expect(user.isEmailVerified, isTrue);
    });

    test('AuthResponseModel.fromJson parses token and nested user', () {
      final json = {
        'access_token': 'jwt-sample-token-xyz',
        'token_type': 'bearer',
        'user': {
          'uid': 'uid-456',
          'email': 'user2@example.com',
          'full_name': 'Second User',
          'subscription_plan': 'premium',
        },
      };

      final authResponse = AuthResponseModel.fromJson(json);

      expect(authResponse.accessToken, equals('jwt-sample-token-xyz'));
      expect(authResponse.tokenType, equals('bearer'));
      expect(authResponse.user.uid, equals('uid-456'));
      expect(authResponse.user.fullName, equals('Second User'));
      expect(authResponse.user.subscriptionPlan, equals('premium'));
    });
  });
}
