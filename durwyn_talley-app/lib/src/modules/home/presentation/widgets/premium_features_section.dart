import '../../../../core/utils/app_exports.dart';
import 'premium_feature_button.dart';
import 'premium_feature_sheet.dart';

class PremiumFeaturesSection extends ConsumerWidget {
  const PremiumFeaturesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFreePlan = ref.watch(subscriptionControllerProvider).isFreePlan;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dashboardPremiumFeaturesTitle,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
        10.ph,
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PremiumFeatureButton(
                  icon: AppAssetsSvg.dashboardHomeGpsHistoryIcn,
                  label: AppStrings.dashboardPremiumFeatureGpsHistory,
                  isLocked: isFreePlan,
                  onTap: () => isFreePlan
                      ? PremiumFeatureSheet.show(
                          context,
                          featureName: AppStrings.dashboardPremiumFeatureGpsHistory,
                        )
                      : AppRouterGo.push(gpsHistoryView),
                ),
              ),
              16.pw,
              Expanded(
                child: PremiumFeatureButton(
                  icon: AppAssetsSvg.dashboardHomeSavedRecordingsIcn,
                  label: AppStrings.dashboardPremiumFeatureSavedRecordings,
                  isLocked: isFreePlan,
                  onTap: () => isFreePlan
                      ? PremiumFeatureSheet.show(
                          context,
                          featureName: AppStrings.dashboardPremiumFeatureSavedRecordings,
                        )
                      : AppRouterGo.push(savedRecordingsView),
                ),
              ),
              16.pw,
              Expanded(
                child: PremiumFeatureButton(
                  icon: AppAssetsSvg.dashboardHomeEmergencyHistoryIcn,
                  label: AppStrings.dashboardPremiumFeatureEmergencyHistory,
                  onTap: () => AppRouterGo.push(emergencyHistoryView),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
