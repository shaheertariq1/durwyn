import '../../../../components/dashboard_header_section.dart';
import '../../../../core/utils/app_exports.dart';
import '../widgets/home_map_card.dart';
import '../widgets/premium_features_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/sos_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardBackground,
      child: Column(
        children: [
          const DashboardHeaderSection(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    const HomeMapCard(),
                    16.ph,
                    const SosButton(),
                    16.ph,
                    const QuickActionsSection(),
                    16.ph,
                    const RecentActivitySection(),
                    16.ph,
                    const PremiumFeaturesSection(),
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
