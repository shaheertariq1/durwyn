import '../../../../core/utils/app_exports.dart';
import 'contact_permission_entity.dart';

class ContactEntity {
  const ContactEntity({
    this.id,
    required this.avatar,
    required this.name,
    required this.relationship,
    required this.phone,
    required this.email,
    this.permissions = const [],
    this.allowGps = true,
    this.allowAudio = true,
    this.allowVideo = false,
  });

  final String? id;
  final String avatar;
  final String name;
  final String relationship;
  final String phone;
  final String email;
  final List<ContactPermissionEntity> permissions;
  final bool allowGps;
  final bool allowAudio;
  final bool allowVideo;

  static List<ContactPermissionEntity> buildPermissionsList({
    bool allowGps = false,
    bool allowAudio = false,
    bool allowVideo = false,
  }) {
    final list = <ContactPermissionEntity>[];
    if (allowGps) {
      list.add(
        const ContactPermissionEntity(
          icon: AppAssetsSvg.dashboardContactsPermissionLocationIcn,
          label: 'GPS',
        ),
      );
    }
    if (allowAudio) {
      list.add(
        const ContactPermissionEntity(
          icon: AppAssetsSvg.dashboardContactsPermissionAudioIcn,
          label: 'Audio',
        ),
      );
    }
    if (allowVideo) {
      list.add(
        const ContactPermissionEntity(
          icon: AppAssetsSvg.dashboardContactsPermissionVideoIcn,
          label: 'Video',
        ),
      );
    }
    return list;
  }
}
