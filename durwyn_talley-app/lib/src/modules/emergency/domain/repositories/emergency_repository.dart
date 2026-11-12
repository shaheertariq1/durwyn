import '../../data/models/incident_model.dart';

abstract class EmergencyRepository {
  Future<IncidentModel> triggerSos({
    required double latitude,
    required double longitude,
    String address = 'Current Location',
    String emergencyType = 'sos',
  });

  Future<IncidentModel> resolveIncident(String incidentId);

  Future<List<IncidentModel>> getIncidentHistory();

  Future<Map<String, dynamic>> startSafetyTimer(
    int durationMinutes, {
    String label = 'Walking Home',
  });

  Future<Map<String, dynamic>> checkInSafetyTimer();

  Future<Map<String, dynamic>> cancelSafetyTimer();

  // Safety Monitor (Premium Plan)
  Future<Map<String, dynamic>> startSafetyMonitor({
    String monitorType = 'Travel Safe',
    double? latitude,
    double? longitude,
  });

  Future<Map<String, dynamic>> pingSafetyMonitor({
    required double latitude,
    required double longitude,
    int? batteryLevel,
    String? status,
  });

  Future<Map<String, dynamic>> stopSafetyMonitor({
    String reason = 'user_completed',
  });

  Future<Map<String, dynamic>> getSafetyMonitorStatus();
}
