import '../../../../core/utils/app_exports.dart';
import 'premium_badge_chip.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.iconBg,
    this.onTap,
    this.isLocked = false,
  });

  final String icon;
  final String label;
  final Color iconBg;
  final VoidCallback? onTap;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: AppInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: isLocked ? 0.6 : 1,
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: 16.circular,
                      ),
                      child: SvgPicture.asset(
                        icon,
                        width: 24.sp,
                        height: 24.sp,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryWhite,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  10.ph,
                  Opacity(
                    opacity: isLocked ? 0.6 : 1,
                    child: Text(
                      label,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLocked)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: const PremiumBadgeChip(),
              ),
          ],
        ),
      ),
    );
  }
}
