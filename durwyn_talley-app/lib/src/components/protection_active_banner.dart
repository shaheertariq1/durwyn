import '../core/utils/app_exports.dart';

class ProtectionActiveBanner extends ConsumerWidget {
  const ProtectionActiveBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planLabel = ref.watch(subscriptionControllerProvider).planLabel;

    return Container(
      padding: AppInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.dashboardProtectionBannerBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.dashboardProtectionBannerBorder),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssetsSvg.dashboardHomeProtectionShieldIcn,
            width: 20.sp,
            height: 20.sp,
          ),
          12.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dashboardProtectionActiveTitle,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.successGreen,
                  ),
                ),
                Text(
                  planLabel,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.dashboardProtectionSubtitle,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Text(
              AppStrings.dashboardManageLabel,
              style: context.labelMediumStyle?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.successGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
