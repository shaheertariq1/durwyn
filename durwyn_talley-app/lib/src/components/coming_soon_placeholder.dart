import '../core/utils/app_exports.dart';

class ComingSoonPlaceholder extends StatelessWidget {
  const ComingSoonPlaceholder({super.key, required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardBackground,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.dashboardCardBg,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              ),
              child: SvgPicture.asset(
                icon,
                width: 28.sp,
                height: 28.sp,
                colorFilter: const ColorFilter.mode(
                  AppColors.coolGray,
                  BlendMode.srcIn,
                ),
              ),
            ),
            16.ph,
            Text(
              label,
              style: context.headlineMediumStyle?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryWhite,
              ),
            ),
            8.ph,
            Text(
              AppStrings.comingSoon,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.coolGray,
              ),
            ),
            4.ph,
            Padding(
              padding: AppInsets.symmetric(horizontal: 48),
              child: Text(
                AppStrings.placeholderComingSoonSubtitle,
                textAlign: TextAlign.center,
                style: context.bodySmallStyle?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
