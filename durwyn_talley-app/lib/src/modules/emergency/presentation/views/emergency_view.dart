import '../../../../components/dashboard_header_section.dart';
import '../../../../core/utils/app_exports.dart';
import '../widgets/emergency_options_section.dart';
import '../widgets/emergency_tips_section.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

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
                    const EmergencyOptionsSection(),
                    16.ph,
                    const EmergencyTipsSection(),
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
