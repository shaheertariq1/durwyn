import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/choose_plan_back_button.dart';
import '../widgets/choose_plan_card.dart';

class ChoosePlanView extends ConsumerWidget {
  const ChoosePlanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChoosePlanBackButton(onTap: AppRouterGo.back),
              40.ph,
              Center(
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  padding: AppInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppAssetsPng.onboardingShieldLogo,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              24.ph,
              Text(
                AppStrings.choosePlanTitle,
                style: context.headlineSmallStyle?.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              4.ph,
              Text(
                AppStrings.choosePlanSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.freePlanName,
                badgeText: AppStrings.currentPlanLabel,
                priceMain: AppStrings.freePlanPrice,
                icon: AppAssetsSvg.choosePlanFreeIcn,
                iconBackgroundColor: AppColors.choosePlanNeutralChip,
                features: AppStrings.freePlanFeatures,
                showPerMonth: false,
                selected: controller.selectedPlan == SubscriptionPlan.free,
                onTap: () => controller.selectPlan(SubscriptionPlan.free),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.standardPlanName,
                priceMain: AppStrings.standardPlanPrice,
                icon: AppAssetsSvg.choosePlanStandardIcn,
                iconBackgroundColor: AppColors.choosePlanBlueIconBg,
                features: AppStrings.standardPlanFeatures,
                selected: controller.selectedPlan == SubscriptionPlan.standard,
                onTap: () => controller.selectPlan(SubscriptionPlan.standard),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.premiumPlanName,
                priceMain: AppStrings.premiumPlanPrice,
                icon: AppAssetsSvg.choosePlanPremiumIcn,
                iconBackgroundColor: AppColors.choosePlanGreenIconBg,
                features: AppStrings.premiumPlanFeatures,
                mostPopular: true,
                selected: controller.selectedPlan == SubscriptionPlan.premium,
                onTap: () => controller.selectPlan(SubscriptionPlan.premium),
              ),
              24.ph,
              PrimaryElevatedButton(
                onTap: controller.confirmPlanSelection,
                text: controller.selectedPlan == SubscriptionPlan.free
                    ? AppStrings.continueWithFreePlan
                    : '${AppStrings.upgradeToPrefix} '
                        '${controller.selectedPlan == SubscriptionPlan.standard ? AppStrings.standardPlanName : AppStrings.premiumPlanName}',
              ),
              24.ph,
              GestureDetector(
                onTap: controller.continueWithFreePlan,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: AppInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppStrings.continueWithFreePlan,
                      textAlign: TextAlign.center,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.coolGray,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
