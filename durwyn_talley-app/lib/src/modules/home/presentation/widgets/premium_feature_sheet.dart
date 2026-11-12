import '../../../../core/utils/app_exports.dart';

/// Bottom sheet shown when a free-plan user taps a locked premium feature
/// (see [PremiumFeatureButton] and [QuickActionCard] `isLocked` taps).
class PremiumFeatureSheet extends StatelessWidget {
  const PremiumFeatureSheet({super.key, required this.featureName});

  /// Name of the locked feature that triggered this sheet, e.g. "Safety
  /// Monitor" — shown bold in the highlighted banner.
  final String featureName;

  static Future<void> show(BuildContext context, {required String featureName}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.dashboardCardBg,
      barrierColor: AppColors.primaryblack.withValues(alpha: 0.35),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        side: BorderSide(
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
          width: 1.088,
        ),
      ),
      builder: (_) => PremiumFeatureSheet(featureName: featureName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.dashboardPremiumSheetCrownIcn,
                    width: 24.sp,
                    height: 24.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.successGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                12.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dashboardPremiumSheetTitle,
                        style: context.titleMediumStyle?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      Text(
                        AppStrings.dashboardPremiumSheetSubtitle,
                        style: context.labelSmallStyle?.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ],
            ),
            16.ph,
            Container(
              width: double.infinity,
              padding: AppInsets.symmetric(horizontal: 17, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.05),
                borderRadius: 16.circular,
                border: Border.all(
                  color: AppColors.successGreen.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssetsSvg.dashboardPremiumSheetBoltIcn,
                    width: 20.sp,
                    height: 20.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.successGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          color: AppColors.primaryWhite,
                        ),
                        children: [
                          TextSpan(
                            text: featureName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: AppStrings.dashboardPremiumSheetBannerSuffix,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.ph,
            Text(
              AppStrings.dashboardPremiumSheetFeaturesTitle,
              style: context.titleLargeStyle?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryWhite,
              ),
            ),
            for (final feature in AppStrings.dashboardPremiumSheetFeatures)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssetsSvg.choosePlanCheckIcn,
                      width: 14.sp,
                      height: 14.sp,
                    ),
                    8.pw,
                    Text(
                      feature,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.coolGray,
                      ),
                    ),
                  ],
                ),
              ),
            16.ph,
            Row(
              children: [
                Expanded(
                  child: _PlanPriceCard(
                    label: AppStrings.standardPlanName,
                    price: AppStrings.standardPlanPrice,
                  ),
                ),
                12.pw,
                Expanded(
                  child: _PlanPriceCard(
                    label: AppStrings.premiumPlanName,
                    price: AppStrings.premiumPlanPrice,
                  ),
                ),
              ],
            ),
            20.ph,
            PrimaryElevatedButton(
              onTap: () {
                Navigator.of(context).pop();
                AppRouterGo.push(changePlanView);
              },
              text: AppStrings.dashboardPremiumSheetUpgradeNow,
              textColor: AppColors.dashboardBackground,
              height: 56.h,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.dashboardBackground,
              ),
            ),
            8.ph,
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: AppInsets.symmetric(vertical: 8),
                child: Text(
                  AppStrings.dashboardPremiumSheetMaybeLater,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.coolGray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanPriceCard extends StatelessWidget {
  const _PlanPriceCard({required this.label, required this.price});

  final String label;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.choosePlanNeutralChip,
        borderRadius: 16.circular,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: context.labelSmallStyle?.copyWith(
              fontSize: 12.sp,
              color: AppColors.primaryWhite.withValues(alpha: 0.6),
            ),
          ),
          4.ph,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: price,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhite,
                    fontFamily: context.bodyMediumStyle?.fontFamily,
                  ),
                ),
                TextSpan(
                  text: AppStrings.perMonthSuffix,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryWhite.withValues(alpha: 0.6),
                    fontFamily: context.bodyMediumStyle?.fontFamily,
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
