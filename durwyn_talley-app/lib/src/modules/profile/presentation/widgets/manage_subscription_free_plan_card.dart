import '../../../../core/utils/app_exports.dart';

class ManageSubscriptionFreePlanCard extends StatelessWidget {
  const ManageSubscriptionFreePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 24.circular,
        border: Border.all(
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.sp,
                height: 40.sp,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.choosePlanNeutralChip,
                ),
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardProfileShieldOutlineIcn,
                  width: 20.sp,
                  height: 20.sp,
                ),
              ),
              12.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.freePlanName,
                      style: context.titleLargeStyle?.copyWith(
                        fontSize: 18.sp,
                        height: 28 / 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    Text(
                      AppStrings.manageSubscriptionFreePlanSubtitle,
                      style: context.bodyMediumStyle?.copyWith(
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
          16.ph,
          Text(
            AppStrings.manageSubscriptionFreePlanUpgradeNote,
            style: context.bodyMediumStyle?.copyWith(
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
