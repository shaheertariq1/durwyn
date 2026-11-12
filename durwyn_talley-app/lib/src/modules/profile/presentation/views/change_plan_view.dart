import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/widgets/choose_plan_card.dart';
import '../controller/profile_controller.dart';
import '../widgets/change_plan_confirm_button.dart';
import '../widgets/change_plan_confirm_dialog.dart';

class ChangePlanView extends ConsumerWidget {
  const ChangePlanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);
    final currentPlan = ref.watch(subscriptionControllerProvider).currentPlan;

    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
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
                  height: 36 / 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              4.ph,
              Text(
                AppStrings.choosePlanSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.freePlanName,
                badgeText: currentPlan == SubscriptionPlan.free
                    ? AppStrings.currentPlanLabel
                    : null,
                priceMain: AppStrings.freePlanPrice,
                icon: AppAssetsSvg.choosePlanFreeIcn,
                iconBackgroundColor: AppColors.choosePlanNeutralChip,
                features: AppStrings.freePlanFeatures,
                selected:
                    controller.changePlanSelected == SubscriptionPlan.free,
                showPerMonth: false,
                onTap: () => controller.selectChangePlan(SubscriptionPlan.free),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.standardPlanName,
                badgeText: currentPlan == SubscriptionPlan.standard
                    ? AppStrings.currentPlanLabel
                    : null,
                priceMain: AppStrings.standardPlanPrice,
                icon: AppAssetsSvg.choosePlanStandardIcn,
                iconBackgroundColor: AppColors.choosePlanBlueIconBg,
                features: AppStrings.standardPlanFeatures,
                selected:
                    controller.changePlanSelected == SubscriptionPlan.standard,
                onTap: () =>
                    controller.selectChangePlan(SubscriptionPlan.standard),
              ),
              24.ph,
              ChoosePlanCard(
                name: AppStrings.premiumPlanName,
                badgeText: currentPlan == SubscriptionPlan.premium
                    ? AppStrings.currentPlanLabel
                    : null,
                priceMain: AppStrings.premiumPlanPrice,
                icon: AppAssetsSvg.choosePlanPremiumIcn,
                iconBackgroundColor: AppColors.choosePlanGreenIconBg,
                features: AppStrings.premiumPlanFeatures,
                selected:
                    controller.changePlanSelected == SubscriptionPlan.premium,
                mostPopular: true,
                onTap: () =>
                    controller.selectChangePlan(SubscriptionPlan.premium),
              ),
              24.ph,
              ChangePlanConfirmButton(
                onTap: () {
                  final selected = controller.changePlanSelected;
                  if (selected == currentPlan) {
                    AppRouterGo.back();
                  } else {
                    ChangePlanConfirmDialog.show(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
