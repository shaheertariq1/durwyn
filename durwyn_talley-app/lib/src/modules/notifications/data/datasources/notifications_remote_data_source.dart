import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationEntity>> getNotifications({String? token});
  Future<void> markAllRead({String? token});
  Future<void> markRead({required String id, String? token});
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  final BaseApiService _apiService;

  NotificationsRemoteDataSourceImpl(this._apiService);

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
  Future<List<NotificationEntity>> getNotifications({String? token}) async {
    final response = await _apiService.requestGET(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.notifications),
      headers: _headers(token),
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    final list = data['notifications'] as List<dynamic>? ?? [];

    return list
        .map((item) => NotificationEntity.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> markAllRead({String? token}) async {
    await _apiService.requestPOST(
      apiRoute:
          ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.notificationsMarkAllRead),
      headers: _headers(token),
      body: {},
    );
  }

  @override
  Future<void> markRead({required String id, String? token}) async {
    await _apiService.requestPATCH(
      apiRoute:
          ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.notificationRead(id)),
      headers: _headers(token),
      body: {},
    );
  }
}

