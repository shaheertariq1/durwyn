import '../../../../core/utils/app_exports.dart';
import 'status_row.dart';

class SafetyMonitorCurrentStatusCard extends StatelessWidget {
  const SafetyMonitorCurrentStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          width: 1.085,
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.dashboardSafetyMonitorCurrentStatusTitle,
            style: context.labelMediumStyle?.copyWith(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhite,
            ),
          ),
          16.ph,
          StatusRow(
            icon: AppAssetsSvg.dashboardSafetyMonitorLocationIcn,
            label: AppStrings.dashboardSafetyMonitorLocationTrackingLabel,
            value: AppStrings.dashboardSafetyMonitorLocationTrackingStatus,
          ),
          16.ph,
          StatusRow(
            icon: AppAssetsSvg.dashboardSafetyMonitorActivityIcn,
            label: AppStrings.dashboardSafetyMonitorMovementDetectionLabel,
            value: AppStrings.dashboardSafetyMonitorMovementDetectionStatus,
          ),
          16.ph,
          StatusRow(
            icon: AppAssetsSvg.dashboardHomeProtectionShieldIcn,
            label: AppStrings.dashboardSafetyMonitorProtectionStatusLabel,
            value: AppStrings.dashboardSafetyMonitorProtectionStatusValue,
          ),
        ],
      ),
    );
  }
}
