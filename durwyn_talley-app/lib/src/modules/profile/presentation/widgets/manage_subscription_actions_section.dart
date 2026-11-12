import '../../../../core/utils/app_exports.dart';
import 'cancel_subscription_dialog.dart';
import 'subscription_action_button.dart';

class ManageSubscriptionActionsSection extends StatelessWidget {
  const ManageSubscriptionActionsSection({super.key});

  Future<void> _handleCancelSubscription(BuildContext context) async {
    final confirmed = await CancelSubscriptionDialog.show(context);
    if (confirmed != true) return;
    Prompts.showToast(AppStrings.manageSubscriptionCancelledToast);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubscriptionActionButton(
          label: AppStrings.manageSubscriptionChangePlan,
          backgroundColor: AppColors.successGreen,
          foregroundColor: AppColors.dashboardBackground,
          onTap: () => AppRouterGo.push(changePlanView),
        ),
        16.ph,
        SubscriptionActionButton(
          label: AppStrings.manageSubscriptionCancel,
          backgroundColor: AppColors.dashboardSosRed.withValues(alpha: 0.1),
          foregroundColor: AppColors.dashboardSosRed,
          onTap: () => _handleCancelSubscription(context),
        ),
      ],
    );
  }
}
