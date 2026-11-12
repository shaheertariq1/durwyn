import '../../../../core/utils/app_exports.dart';
import '../../../dashboard/presentation/controller/dashboard_controller.dart';
import 'premium_feature_sheet.dart';
import 'quick_action_card.dart';

class QuickActionsSection extends ConsumerWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPlan = ref.watch(subscriptionControllerProvider).currentPlan;
    final isFreePlan = currentPlan == SubscriptionPlan.free;
    final isSafetyMonitorLocked = currentPlan != SubscriptionPlan.premium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dashboardQuickActionsTitle,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
        10.ph,
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                icon: AppAssetsSvg.dashboardHomeSafetyTimerIcn,
                label: AppStrings.dashboardQuickActionSafetyTimer,
                iconBg: AppColors.dashboardQuickActionBlue,
                onTap: () => AppRouterGo.push(safetyTimerView),
              ),
            ),
            16.pw,
            Expanded(
              child: QuickActionCard(
                icon: AppAssetsSvg.dashboardHomeSafetyMonitorIcn,
                label: AppStrings.dashboardQuickActionSafetyMonitor,
                iconBg: AppColors.dashboardQuickActionPurple,
                isLocked: isSafetyMonitorLocked,
                onTap: () => isSafetyMonitorLocked
                    ? PremiumFeatureSheet.show(
                        context,
                        featureName: AppStrings.dashboardQuickActionSafetyMonitor,
                      )
                    : AppRouterGo.push(safetyMonitorView),
              ),
            ),
          ],
        ),
        16.ph,
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                icon: AppAssetsSvg.dashboardHomeSilentEmergencyIcn,
                label: AppStrings.dashboardQuickActionSilentEmergency,
                iconBg: AppColors.dashboardQuickActionOrange,
                isLocked: isFreePlan,
                onTap: () => isFreePlan
                    ? PremiumFeatureSheet.show(
                        context,
                        featureName: AppStrings.dashboardQuickActionSilentEmergency,
                      )
                    : AppRouterGo.push(silentEmergencyView),
              ),
            ),
            16.pw,
            Expanded(
              child: QuickActionCard(
                icon: AppAssetsSvg.dashboardHomeEmergencyContactsIcn,
                label: AppStrings.dashboardQuickActionEmergencyContacts,
                iconBg: AppColors.dashboardQuickActionGreen,
                onTap: () => ref.read(dashboardControllerProvider).onTabTapped(2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
