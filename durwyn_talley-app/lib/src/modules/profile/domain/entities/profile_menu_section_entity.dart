import 'profile_menu_item_entity.dart';

class ProfileMenuSectionEntity {
  const ProfileMenuSectionEntity({required this.title, required this.items});

  final String title;
  final List<ProfileMenuItemEntity> items;
}
