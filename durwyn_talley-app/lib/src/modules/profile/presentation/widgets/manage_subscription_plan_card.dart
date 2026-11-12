import '../../../../core/utils/app_exports.dart';
import 'plan_detail_row.dart';

class ManageSubscriptionPlanCard extends ConsumerWidget {
  const ManageSubscriptionPlanCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subPlan = ref.watch(subscriptionControllerProvider).currentPlan;
    final isPremium = subPlan == SubscriptionPlan.premium;
    final planName = isPremium
        ? AppStrings.manageSubscriptionPremiumPlan
        : 'Standard Plan';
    final price = isPremium ? '\$29.99' : '\$9.99';

    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: 16.circular,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.successGreen,
            AppColors.successGreen.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssetsSvg.dashboardProfilePremiumShieldIcn,
                width: 32.sp,
                height: 32.sp,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryWhite,
                  BlendMode.srcIn,
                ),
              ),
              12.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      planName,
                      style: context.headlineMediumStyle?.copyWith(
                        fontSize: 24.sp,
                        height: 32 / 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    Text(
                      AppStrings.manageSubscriptionQuarterly,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryWhite.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          PlanDetailRow(
            label: AppStrings.manageSubscriptionPrice,
            value: price,
            isPrice: true,
          ),
          16.ph,
          const PlanDetailRow(
            label: AppStrings.manageSubscriptionBillingCycle,
            value: AppStrings.manageSubscriptionBillingCycleValue,
          ),
          16.ph,
          const PlanDetailRow(
            label: AppStrings.manageSubscriptionNextBillingDate,
            value: AppStrings.manageSubscriptionNextBillingDateValue,
          ),
        ],
      ),
    );
  }
}
