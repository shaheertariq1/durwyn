import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import '../widgets/cancellation_note.dart';
import '../widgets/manage_subscription_actions_section.dart';
import '../widgets/manage_subscription_details_section.dart';
import '../widgets/manage_subscription_free_plan_card.dart';
import '../widgets/manage_subscription_header.dart';
import '../widgets/manage_subscription_plan_card.dart';
import '../widgets/subscription_action_button.dart';
import '../widgets/subscription_features_card.dart';
import '../widgets/update_payment_method_sheet.dart';

class ManageSubscriptionView extends ConsumerWidget {
  const ManageSubscriptionView({super.key});

  Future<void> _showUpdatePaymentMethodSheet(
    BuildContext context,
    ProfileController controller,
  ) async {
    controller.resetSubscriptionSheetFields();
    final updated = await showModalBottomSheet<bool>(
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
      builder: (context) => const UpdatePaymentMethodSheet(),
    );

    if (updated != true) return;
    Prompts.showToast(AppStrings.manageSubscriptionPaymentUpdated);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);
    final isFreePlan = ref.watch(subscriptionControllerProvider).isFreePlan;

    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ManageSubscriptionHeader(),
              32.ph,
              if (isFreePlan) ...[
                const ManageSubscriptionFreePlanCard(),
                16.ph,
                const SubscriptionFeaturesCard(
                  title: AppStrings.manageSubscriptionFreeFeaturesTitle,
                  features: AppStrings.manageSubscriptionFreeFeatures,
                ),
                32.ph,
                SubscriptionActionButton(
                  label: AppStrings.manageSubscriptionUpgradeToPremium,
                  backgroundColor: AppColors.successGreen,
                  foregroundColor: AppColors.dashboardBackground,
                  onTap: () => AppRouterGo.push(changePlanView),
                ),
                16.ph,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppStrings.manageSubscriptionUpgradeAnytimeNote,
                    textAlign: TextAlign.center,
                    style: context.bodySmallStyle?.copyWith(
                      fontSize: 12.sp,
                      height: 16 / 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
              ] else ...[
                const ManageSubscriptionPlanCard(),
                16.ph,
                ManageSubscriptionDetailsSection(
                  cardNumber: controller.manageSubscriptionCardNumber,
                  expiry: controller.manageSubscriptionCardExpiry,
                  onUpdatePaymentMethod: () =>
                      _showUpdatePaymentMethodSheet(context, controller),
                ),
                32.ph,
                const ManageSubscriptionActionsSection(),
                24.ph,
                const CancellationNote(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
