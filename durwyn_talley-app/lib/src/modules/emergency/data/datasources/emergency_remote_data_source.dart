import 'dart:convert';
import '../../../../core/services/network_service/base_api_service.dart';
import '../../../../core/services/network_service/entities/loader_entity.dart';
import '../../../../core/services/network_service/routes/api_routes.dart';
import '../models/incident_model.dart';

abstract class EmergencyRemoteDataSource {
  Future<IncidentModel> triggerSos({
    required String token,
    required double latitude,
    required double longitude,
    String address = 'Current Location',
    String emergencyType = 'sos',
  });

  Future<IncidentModel> resolveIncident({
    required String token,
    required String incidentId,
  });

  Future<List<IncidentModel>> getIncidentHistory({required String token});

  Future<Map<String, dynamic>> startSafetyTimer({
    required String token,
    required int durationMinutes,
    String label = 'Walking Home',
  });

  Future<Map<String, dynamic>> checkInSafetyTimer({required String token});

  Future<Map<String, dynamic>> cancelSafetyTimer({required String token});

  // Safety Monitor (Premium Plan)
  Future<Map<String, dynamic>> startSafetyMonitor({
    required String token,
    String monitorType = 'Travel Safe',
    double? latitude,
    double? longitude,
  });

  Future<Map<String, dynamic>> pingSafetyMonitor({
    required String token,
    required double latitude,
    required double longitude,
    int? batteryLevel,
    String? status,
  });

  Future<Map<String, dynamic>> stopSafetyMonitor({
    required String token,
    String reason = 'user_completed',
  });

  Future<Map<String, dynamic>> getSafetyMonitorStatus({required String token});
}

class EmergencyRemoteDataSourceImpl implements EmergencyRemoteDataSource {
  final BaseApiService _apiService;

  EmergencyRemoteDataSourceImpl(this._apiService);

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  @override
  Future<IncidentModel> triggerSos({
    required String token,
    required double latitude,
    required double longitude,
    String address = 'Current Location',
    String emergencyType = 'sos',
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(baseUrl: null, endpoint: ApiRoutes.sos),
      headers: _headers(token),
      body: {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'emergency_type': emergencyType,
      },
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return IncidentModel.fromJson(data);
  }

  @override
  Future<IncidentModel> resolveIncident({
    required String token,
    required String incidentId,
  }) async {
    final response = await _apiService.requestPUT(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.incidentResolve(incidentId),
      ),
      headers: _headers(token),
      body: {},
    );

    final Map<String, dynamic> data =
        response is String ? jsonDecode(response) : response;
    return IncidentModel.fromJson(data);
  }

  @override
  Future<List<IncidentModel>> getIncidentHistory({required String token}) async {
    final response = await _apiService.requestGET(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.emergencyHistory,
      ),
      headers: _headers(token),
    );

    final dynamic data = response is String ? jsonDecode(response) : response;
    if (data is List) {
      return data
          .map((e) => IncidentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<Map<String, dynamic>> startSafetyTimer({
    required String token,
    required int durationMinutes,
    String label = 'Walking Home',
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyTimerStart,
      ),
      headers: _headers(token),
      body: {
        'duration_minutes': durationMinutes,
        'label': label,
      },
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> checkInSafetyTimer({required String token}) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyTimerCheckin,
      ),
      headers: _headers(token),
      body: {'is_safe': true},
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> cancelSafetyTimer({required String token}) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyTimerCancel,
      ),
      headers: _headers(token),
      body: {},
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> startSafetyMonitor({
    required String token,
    String monitorType = 'Travel Safe',
    double? latitude,
    double? longitude,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyMonitorStart,
      ),
      headers: _headers(token),
      body: {
        'monitor_type': monitorType,
        'latitude': latitude ?? 37.7749,
        'longitude': longitude ?? -122.4194,
        'check_in_interval_minutes': 15,
      },
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> pingSafetyMonitor({
    required String token,
    required double latitude,
    required double longitude,
    int? batteryLevel,
    String? status,
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyMonitorPing,
      ),
      headers: _headers(token),
      body: {
        'latitude': latitude,
        'longitude': longitude,
        if (batteryLevel != null) 'battery_level': batteryLevel,
        if (status != null) 'status': status,
      },
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> stopSafetyMonitor({
    required String token,
    String reason = 'user_completed',
  }) async {
    final response = await _apiService.requestPOST(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyMonitorStop,
      ),
      headers: _headers(token),
      body: {'reason': reason},
    );

    return response is String ? jsonDecode(response) : response;
  }

  @override
  Future<Map<String, dynamic>> getSafetyMonitorStatus({
    required String token,
  }) async {
    final response = await _apiService.requestGET(
      apiRoute: ApiRouteEntity(
        baseUrl: null,
        endpoint: ApiRoutes.safetyMonitorStatus,
      ),
      headers: _headers(token),
    );

    return response is String ? jsonDecode(response) : response;
  }
}
