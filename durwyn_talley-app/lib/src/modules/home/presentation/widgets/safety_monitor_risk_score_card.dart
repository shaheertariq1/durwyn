import '../../../../core/utils/app_exports.dart';

class SafetyMonitorRiskScoreCard extends StatelessWidget {
  const SafetyMonitorRiskScoreCard({super.key, required this.riskScore});

  final double riskScore;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.dashboardSafetyMonitorRiskScoreTitle,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryWhite,
                ),
              ),
              Text(
                '${(riskScore * 100).round()}%',
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 24.sp,
                  height: 32 / 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
          16.ph,
          ClipRRect(
            borderRadius: 999.circular,
            child: LinearProgressIndicator(
              value: riskScore,
              minHeight: 12.h,
              backgroundColor: AppColors.choosePlanNeutralChip,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.successGreen,
              ),
            ),
          ),
          8.ph,
          Text(
            AppStrings.dashboardSafetyMonitorLowRiskLabel,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w400,
              color: AppColors.coolGray,
            ),
          ),
        ],
      ),
    );
  }
}
