import '../../../../core/utils/app_exports.dart';

class ChoosePlanCard extends StatelessWidget {
  const ChoosePlanCard({
    super.key,
    required this.name,
    required this.priceMain,
    required this.icon,
    required this.iconBackgroundColor,
    required this.features,
    required this.selected,
    required this.onTap,
    this.badgeText,
    this.mostPopular = false,
    this.showPerMonth = true,
  });

  final String name;
  final String priceMain;
  final String icon;
  final Color iconBackgroundColor;
  final List<String> features;
  final bool selected;
  final VoidCallback onTap;
  final String? badgeText;
  final bool mostPopular;
  final bool showPerMonth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: double.infinity,
            padding: AppInsets.all(20),
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.choosePlanPremiumCardBg
                  : AppColors.otpFieldFill,
              borderRadius: 16.circular,
              border: Border.all(
                color: selected
                    ? AppColors.successGreen
                    : AppColors.signInDarkBorder,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppInsets.only(top: 2),
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? AppColors.successGreen
                          : AppColors.transparent,
                      border: Border.all(
                        color: selected
                            ? AppColors.successGreen
                            : AppColors.signInDarkBorder,
                      ),
                    ),
                    child: selected
                        ? Center(
                            child: Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryWhite,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                16.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: iconBackgroundColor,
                              borderRadius: 12.circular,
                            ),
                            child: SvgPicture.asset(
                              icon,
                              width: 16.w,
                              height: 16.h,
                            ),
                          ),
                          12.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        name,
                                        style:
                                            context.titleMediumStyle?.copyWith(
                                          fontSize: 16.sp,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryWhite,
                                        ),
                                      ),
                                    ),
                                    if (badgeText != null) ...[
                                      8.pw,
                                      Container(
                                        padding: AppInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.choosePlanNeutralChip,
                                          borderRadius: 100.circular,
                                        ),
                                        child: Text(
                                          badgeText!,
                                          style:
                                              context.labelSmallStyle?.copyWith(
                                            fontSize: 12.sp,
                                            height: 16 / 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.coolGray,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      priceMain,
                                      style: context.titleLargeStyle?.copyWith(
                                        fontSize: 18.sp,
                                        height: 28 / 18,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryWhite,
                                      ),
                                    ),
                                    if (showPerMonth)
                                      Text(
                                        AppStrings.perMonthSuffix,
                                        style:
                                            context.labelSmallStyle?.copyWith(
                                          fontSize: 12.sp,
                                          height: 16 / 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.coolGray,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      8.ph,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final feature in features) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: AppInsets.only(top: 3),
                                  child: SvgPicture.asset(
                                    AppAssetsSvg.choosePlanCheckIcn,
                                    width: 14.w,
                                    height: 14.h,
                                  ),
                                ),
                                8.pw,
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: context.bodySmallStyle?.copyWith(
                                      fontSize: 14.sp,
                                      height: 20 / 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.coolGray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (feature != features.last) 4.ph,
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (mostPopular)
          Positioned(
            top: -12,
            right: 0,
            child: Container(
              padding: AppInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successGreen,
                borderRadius: 100.circular,
              ),
              child: Text(
                AppStrings.mostPopularLabel,
                style: context.labelSmallStyle?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.splashScrimColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
