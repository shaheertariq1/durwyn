import '../../../../core/utils/app_exports.dart';
import 'activity_row.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dashboardRecentActivityTitle,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
        10.ph,
        Container(
          decoration: BoxDecoration(
            color: AppColors.dashboardCardBg,
            borderRadius: 16.circular,
            border: Border.all(
              color: AppColors.primaryWhite.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              ActivityRow(
                title: AppStrings.dashboardActivitySafetyCheckTitle,
                time: AppStrings.dashboardActivitySafetyCheckTime,
                dotColor: AppColors.successGreen,
                showDivider: true,
              ),
              ActivityRow(
                title: AppStrings.dashboardActivityTimerCompletedTitle,
                time: AppStrings.dashboardActivityTimerCompletedTime,
                dotColor: AppColors.successGreen,
                showDivider: true,
              ),
              ActivityRow(
                title: AppStrings.dashboardActivityContactAddedTitle,
                time: AppStrings.dashboardActivityContactAddedTime,
                dotColor: AppColors.dashboardActivityBlueDot,
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
