import 'dashboard_header.dart';
import 'protection_active_banner.dart';
import '../core/utils/app_exports.dart';

class DashboardHeaderSection extends StatelessWidget {
  const DashboardHeaderSection({super.key, this.showProtectionBanner = true});

  final bool showProtectionBanner;

  @override
  Widget build(BuildContext context) {
    final topSafeArea = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topSafeArea,
        bottom: 24.h,
        left: 24.w,
        right: 24.w,
      ),
      color: AppColors.dashboardCardBg,
      child: Column(
        children: [
          const DashboardHeader(),
          if (showProtectionBanner) ...[16.ph, const ProtectionActiveBanner()],
        ],
      ),
    );
  }
}
