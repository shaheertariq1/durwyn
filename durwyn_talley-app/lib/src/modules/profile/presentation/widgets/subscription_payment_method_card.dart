import '../../../../core/utils/app_exports.dart';
import 'subscription_card.dart';
import 'subscription_card_title.dart';

class SubscriptionPaymentMethodCard extends StatelessWidget {
  const SubscriptionPaymentMethodCard({
    super.key,
    required this.cardNumber,
    required this.expiry,
    required this.onUpdate,
  });

  final String cardNumber;
  final String expiry;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return SubscriptionCard(
      child: Column(
        children: [
          SubscriptionCardTitle(
            title: AppStrings.dashboardProfilePaymentMethod,
            action: AppStrings.manageSubscriptionUpdate,
            onActionTap: onUpdate,
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
