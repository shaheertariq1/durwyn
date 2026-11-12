import '../../../../core/utils/app_exports.dart';

class PremiumBadgeChip extends StatelessWidget {
  const PremiumBadgeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.1),
        borderRadius: 999.circular,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssetsSvg.dashboardHomeFeatureLockIcn,
            width: 12.sp,
            height: 12.sp,
            colorFilter: const ColorFilter.mode(
              AppColors.successGreen,
              BlendMode.srcIn,
            ),
          ),
          4.pw,
          Text(
            AppStrings.dashboardPremiumBadgeLabel,
            style: context.labelSmallStyle?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.successGreen,
            ),
          ),
        ],
      ),
    );
  }
}
