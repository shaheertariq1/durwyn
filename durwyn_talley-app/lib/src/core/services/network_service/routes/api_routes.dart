import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  /// Serving URL (defaults to local FastAPI backend on emulator/device)
  static String get baseUrl {
    final envUrl = dotenv.maybeGet('BASE_URL');
    if (envUrl != null && envUrl.isNotEmpty && !envUrl.contains('example.com')) {
      return envUrl;
    }
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api/v1';
    }
    return 'http://127.0.0.1:8000/api/v1';
  }

  // Auth Routes
  static const String signup = '/auth/signup';
  static const String signin = '/auth/signin';
  static const String me = '/auth/me';
  static const String phoneSendCode = '/auth/phone/send-code';
  static const String phoneVerifyCode = '/auth/phone/verify-code';
  static const String phoneResendCode = '/auth/phone/resend-code';

  // Notifications Routes
  static const String notifications = '/notifications';
  static String notificationRead(String id) => '/notifications/$id/read';
  static const String notificationsMarkAllRead = '/notifications/mark-all-read';

  // User Management Routes
  static const String users = '/users';
  static String userProfile(String uid) => '/users/$uid/profile';
  static String userPlan(String uid) => '/users/$uid/plan';
  static String userEmergency(String uid) => '/users/$uid/emergency';

  // Emergency Contacts Routes
  static const String contacts = '/contacts';
  static String contact(String contactId) => '/contacts/$contactId';

  // Emergency Routes
  static const String sos = '/emergency/sos';
  static String incidentResolve(String incidentId) =>
      '/emergency/incidents/$incidentId/resolve';
  static const String emergencyHistory = '/emergency/history';
  static const String safetyTimerStart = '/emergency/timer/start';
  static const String safetyTimerCheckin = '/emergency/timer/checkin';
  static const String safetyTimerCancel = '/emergency/timer/cancel';

  // Safety Monitor Routes (Premium Plan)
  static const String safetyMonitorStart = '/emergency/monitor/start';
  static const String safetyMonitorPing = '/emergency/monitor/ping';
  static const String safetyMonitorStop = '/emergency/monitor/stop';
  static const String safetyMonitorStatus = '/emergency/monitor/status';
}
