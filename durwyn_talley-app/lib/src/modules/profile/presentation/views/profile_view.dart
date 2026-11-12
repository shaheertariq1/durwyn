import '../../../../core/utils/app_exports.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_menu_list_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardBackground,
      child: Column(
        children: [
          const ProfileHeaderSection(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 24, vertical: 24),
                child: const ProfileMenuListSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
