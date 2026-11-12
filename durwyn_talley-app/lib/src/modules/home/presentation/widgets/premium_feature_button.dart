import '../../../../core/utils/app_exports.dart';
import 'premium_badge_chip.dart';

class PremiumFeatureButton extends StatelessWidget {
  const PremiumFeatureButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.isLocked = false,
  });

  final String icon;
  final String label;
  final VoidCallback? onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: AppInsets.symmetric(horizontal: 11, vertical: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 24.sp,
                    height: 24.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.successGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                  8.ph,
                  Opacity(
                    opacity: isLocked ? 0.6 : 1,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: context.labelSmallStyle?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                  if (isLocked) ...[8.ph, const PremiumBadgeChip()],
                ],
              ),
            ),
            if (isLocked)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardHomeFeatureLockIcn,
                  width: 14.sp,
                  height: 14.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
