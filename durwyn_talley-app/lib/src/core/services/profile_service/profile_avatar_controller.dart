import 'package:durwyn_talley/src/core/utils/app_exports.dart';

/// Single source of truth for the signed-in user's profile avatar, so a
/// photo picked from onboarding, the dashboard header, or the edit-profile
/// screen shows up consistently everywhere the avatar is displayed.
class ProfileAvatarController extends ChangeNotifier {
  ProfileAvatarController() {
    _loadSavedAvatar();
  }

  File? avatar;

  Future<void> _loadSavedAvatar() async {
    try {
      final path = await locator<Prefs>().read('local_avatar_path');
      if (path != null && path.isNotEmpty) {
        final f = File(path);
        if (await f.exists()) {
          avatar = f;
          notifyListeners();
        }
      }
    } catch (_) {}
  }

  Future<void> setAvatar(File? file) async {
    if (file == null) return;
    avatar = file;
    notifyListeners();
    try {
      await locator<Prefs>().store('local_avatar_path', file.path);
    } catch (_) {}
  }
}

final profileAvatarControllerProvider =
    ChangeNotifierProvider<ProfileAvatarController>(
  (ref) => ProfileAvatarController(),
);
