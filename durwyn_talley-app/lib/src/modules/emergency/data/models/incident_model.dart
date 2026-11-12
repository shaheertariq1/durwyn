class IncidentModel {
  final String id;
  final String uid;
  final String userName;
  final String? userPhone;
  final String emergencyType;
  final String status;
  final double latitude;
  final double longitude;
  final String address;
  final String emergencyMessage;
  final List<dynamic> contactsAlerted;
  final String liveTrackingUrl;
  final String createdAt;
  final String? resolvedAt;

  const IncidentModel({
    required this.id,
    required this.uid,
    required this.userName,
    this.userPhone,
    required this.emergencyType,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.emergencyMessage,
    this.contactsAlerted = const [],
    required this.liveTrackingUrl,
    required this.createdAt,
    this.resolvedAt,
  });

  factory IncidentModel.fromJson(Map<String, dynamic> json) {
    return IncidentModel(
      id: json['id'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      userPhone: json['user_phone'] as String?,
      emergencyType: json['emergency_type'] as String? ?? 'sos',
      status: json['status'] as String? ?? 'active',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      address: json['address'] as String? ?? 'Current Location',
      emergencyMessage: json['emergency_message'] as String? ?? '',
      contactsAlerted: json['contacts_alerted'] as List<dynamic>? ?? [],
      liveTrackingUrl: json['live_tracking_url'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      resolvedAt: json['resolved_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'user_name': userName,
      'user_phone': userPhone,
      'emergency_type': emergencyType,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'emergency_message': emergencyMessage,
      'contacts_alerted': contactsAlerted,
      'live_tracking_url': liveTrackingUrl,
      'created_at': createdAt,
      'resolved_at': resolvedAt,
    };
  }
}
