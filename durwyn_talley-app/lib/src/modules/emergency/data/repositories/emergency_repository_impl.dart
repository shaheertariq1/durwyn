import '../../../../core/services/local_db_service/secure_storage.dart';
import '../../domain/repositories/emergency_repository.dart';
import '../datasources/emergency_remote_data_source.dart';
import '../models/incident_model.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  final EmergencyRemoteDataSource _remoteDataSource;
  final Prefs _prefs;

  EmergencyRepositoryImpl(this._remoteDataSource, this._prefs);

  Future<String> _getToken() async {
    final token = await _prefs.fetchToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not authenticated. Please log in.');
    }
    return token;
  }

  @override
  Future<IncidentModel> triggerSos({
    required double latitude,
    required double longitude,
    String address = 'Current Location',
    String emergencyType = 'sos',
  }) async {
    final token = await _getToken();
    return await _remoteDataSource.triggerSos(
      token: token,
      latitude: latitude,
      longitude: longitude,
      address: address,
      emergencyType: emergencyType,
    );
  }

  @override
  Future<IncidentModel> resolveIncident(String incidentId) async {
    final token = await _getToken();
    return await _remoteDataSource.resolveIncident(
      token: token,
      incidentId: incidentId,
    );
  }

  @override
  Future<List<IncidentModel>> getIncidentHistory() async {
    final token = await _getToken();
    return await _remoteDataSource.getIncidentHistory(token: token);
  }

  @override
  Future<Map<String, dynamic>> startSafetyTimer(
    int durationMinutes, {
    String label = 'Walking Home',
  }) async {
    final token = await _getToken();
    return await _remoteDataSource.startSafetyTimer(
      token: token,
      durationMinutes: durationMinutes,
      label: label,
    );
  }

  @override
  Future<Map<String, dynamic>> checkInSafetyTimer() async {
    final token = await _getToken();
    return await _remoteDataSource.checkInSafetyTimer(token: token);
  }

  @override
  Future<Map<String, dynamic>> cancelSafetyTimer() async {
    final token = await _getToken();
    return await _remoteDataSource.cancelSafetyTimer(token: token);
  }

  // Safety Monitor (Premium Plan)
  @override
  Future<Map<String, dynamic>> startSafetyMonitor({
    String monitorType = 'Travel Safe',
    double? latitude,
    double? longitude,
  }) async {
    final token = await _getToken();
    return await _remoteDataSource.startSafetyMonitor(
      token: token,
      monitorType: monitorType,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<Map<String, dynamic>> pingSafetyMonitor({
    required double latitude,
    required double longitude,
    int? batteryLevel,
    String? status,
  }) async {
    final token = await _getToken();
    return await _remoteDataSource.pingSafetyMonitor(
      token: token,
      latitude: latitude,
      longitude: longitude,
      batteryLevel: batteryLevel,
      status: status,
    );
  }

  @override
  Future<Map<String, dynamic>> stopSafetyMonitor({
    String reason = 'user_completed',
  }) async {
    final token = await _getToken();
    return await _remoteDataSource.stopSafetyMonitor(
      token: token,
      reason: reason,
    );
  }

  @override
  Future<Map<String, dynamic>> getSafetyMonitorStatus() async {
    final token = await _getToken();
    return await _remoteDataSource.getSafetyMonitorStatus(token: token);
  }
}
