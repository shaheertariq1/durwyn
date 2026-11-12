import '../../../../core/utils/app_exports.dart';
import '../widgets/notifications_list_section.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
            child: const NotificationsListSection(),
          ),
        ),
      ),
    );
  }
}
