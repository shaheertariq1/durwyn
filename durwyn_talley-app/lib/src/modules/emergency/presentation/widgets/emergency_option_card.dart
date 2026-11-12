import '../../../../core/utils/app_exports.dart';

class EmergencyOptionCard extends StatelessWidget {
  const EmergencyOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    this.onTap,
  });

  final String icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        padding: AppInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBg, borderRadius: 16.circular),
              child: SvgPicture.asset(
                icon,
                width: 28.sp,
                height: 28.sp,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryWhite,
                  BlendMode.srcIn,
                ),
              ),
            ),
            16.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.labelMediumStyle?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.travellerMutedText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
