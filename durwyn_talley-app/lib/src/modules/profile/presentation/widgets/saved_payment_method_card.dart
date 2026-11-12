import '../../../../core/utils/app_exports.dart';

class SavedPaymentMethodCard extends StatelessWidget {
  const SavedPaymentMethodCard({
    super.key,
    required this.cardNumber,
    required this.expiry,
    required this.onEdit,
  });

  final String cardNumber;
  final String expiry;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.dashboardProfilePaymentMethod,
                style: context.titleMediumStyle?.copyWith(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryWhite,
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  AppStrings.profilePaymentMethodEdit,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.successGreen,
                  ),
                ),
              ),
            ],
          ),
          10.ph,
          Row(
            children: [
              Container(
                width: 48.sp,
                height: 48.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.choosePlanNeutralChip,
                  borderRadius: 16.circular,
                ),
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardProfileCardIcn,
                  width: 24.sp,
                  height: 24.sp,
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
                      cardNumber,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    Text(
                      expiry,
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
        ],
      ),
    );
  }
}
