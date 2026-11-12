import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    super.id,
    required super.name,
    required super.relationship,
    required super.phone,
    required super.email,
    super.avatar = AppAssetsPng.dashboardContactsAvatarDummy1,
    super.permissions = const [],
    super.allowGps = true,
    super.allowAudio = true,
    super.allowVideo = false,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    final allowGps = json['allow_gps'] as bool? ?? true;
    final allowAudio = json['allow_audio'] as bool? ?? true;
    final allowVideo = json['allow_video'] as bool? ?? false;

    return ContactModel(
      id: json['id'] as String?,
      name: json['full_name'] as String? ?? 'Contact',
      relationship: json['relationship'] as String? ?? 'Emergency Contact',
      phone: json['phone_number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatar: (json['avatar_url'] != null && (json['avatar_url'] as String).isNotEmpty)
          ? json['avatar_url'] as String
          : AppAssetsPng.dashboardContactsAvatarDummy1,
      allowGps: allowGps,
      allowAudio: allowAudio,
      allowVideo: allowVideo,
      permissions: ContactEntity.buildPermissionsList(
        allowGps: allowGps,
        allowAudio: allowAudio,
        allowVideo: allowVideo,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'phone_number': phone,
      'email': email.isEmpty ? null : email,
      'relationship': relationship,
      'avatar_url': avatar,
      'allow_gps': allowGps,
      'allow_audio': allowAudio,
      'allow_video': allowVideo,
    };
  }
}
