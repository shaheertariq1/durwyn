import '../../../../core/utils/app_exports.dart';

class SafetyMonitorActivityLogCard extends StatelessWidget {
  const SafetyMonitorActivityLogCard({super.key});

  static const List<({Color dotColor, String title, String time})> _entries =
      [
        (
          dotColor: AppColors.dashboardActivityBlueDot,
          title: AppStrings.dashboardSafetyMonitorStartedLogTitle,
          time: AppStrings.dashboardSafetyMonitorJustNowLabel,
        ),
        (
          dotColor: AppColors.successGreen,
          title: AppStrings.dashboardSafetyMonitorLocationUpdatedLogTitle,
          time: AppStrings.dashboardSafetyMonitorTwoMinsAgoLabel,
        ),
        (
          dotColor: AppColors.successGreen,
          title: AppStrings.dashboardSafetyMonitorMovementDetectedLogTitle,
          time: AppStrings.dashboardSafetyMonitorFiveMinsAgoLabel,
        ),
      ];

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
            AppStrings.dashboardSafetyMonitorActivityLogTitle,
            style: context.labelMediumStyle?.copyWith(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhite,
            ),
          ),
          10.ph,
          for (final entry in _entries)
            Padding(
              padding: AppInsets.only(top: entry == _entries.first ? 0 : 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: AppInsets.only(top: 8),
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: entry.dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.title,
                          style: context.bodyMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                        Text(
                          entry.time,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
