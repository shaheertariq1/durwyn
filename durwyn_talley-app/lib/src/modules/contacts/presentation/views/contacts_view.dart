import '../../../../components/dashboard_header_section.dart';
import '../../../../core/utils/app_exports.dart';
import '../widgets/contacts_auto_call_banner.dart';
import '../widgets/contacts_list_section.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardBackground,
      child: Column(
        children: [
          const DashboardHeaderSection(showProtectionBanner: false),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    const ContactsListSection(),
                    16.ph,
                    const ContactsAutoCallBanner(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
