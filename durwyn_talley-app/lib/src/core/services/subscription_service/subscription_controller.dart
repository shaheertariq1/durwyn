import 'package:durwyn_talley/src/core/utils/app_exports.dart';

/// Single source of truth for the signed-in user's active subscription
/// plan. Defaults to [SubscriptionPlan.free] until sign-up or the
/// change-plan flow commits a different plan.
class SubscriptionController extends ChangeNotifier {
  SubscriptionPlan currentPlan = SubscriptionPlan.free;

  bool get isFreePlan => currentPlan == SubscriptionPlan.free;

  String get planLabel => switch (currentPlan) {
    SubscriptionPlan.free => AppStrings.freePlanName,
    SubscriptionPlan.standard => '${AppStrings.standardPlanName} Plan',
    SubscriptionPlan.premium => '${AppStrings.premiumPlanName} Plan',
  };

  void setPlan(SubscriptionPlan plan) {
    if (currentPlan == plan) return;
    currentPlan = plan;
    notifyListeners();
  }
}

final subscriptionControllerProvider =
    ChangeNotifierProvider<SubscriptionController>(
      (ref) => SubscriptionController(),
    );
