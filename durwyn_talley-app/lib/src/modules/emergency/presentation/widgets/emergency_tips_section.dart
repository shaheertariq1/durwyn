import '../../../../core/utils/app_exports.dart';

class EmergencyTipsSection extends StatelessWidget {
  const EmergencyTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardProtectionBannerBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.dashboardProtectionBannerBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.dashboardEmergencyTipsTitle,
            style: context.labelMediumStyle?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.successGreen,
            ),
          ),
          10.ph,
          Text(
            AppStrings.dashboardEmergencyTip1,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.successGreen.withValues(alpha: 0.9),
            ),
          ),
          8.ph,
          Text(
            AppStrings.dashboardEmergencyTip2,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.successGreen.withValues(alpha: 0.9),
            ),
          ),
          8.ph,
          Text(
            AppStrings.dashboardEmergencyTip3,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.successGreen.withValues(alpha: 0.9),
            ),
          ),
          8.ph,
          Text(
            AppStrings.dashboardEmergencyTip4,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.successGreen.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
