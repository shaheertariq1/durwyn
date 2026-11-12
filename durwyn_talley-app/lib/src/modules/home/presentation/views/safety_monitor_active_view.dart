import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';
import '../widgets/safety_monitor_activity_log_card.dart';
import '../widgets/safety_monitor_current_status_card.dart';
import '../widgets/safety_monitor_risk_score_card.dart';

class SafetyMonitorActiveView extends ConsumerWidget {
  const SafetyMonitorActiveView({super.key});

  static const double _riskScore = 0.15;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24.h,
                bottom: 24.h,
                left: 24.w,
                right: 24.w,
              ),
              color: AppColors.dashboardQuickActionPurple,
              child: Column(
                children: [
                  Container(
                    padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhite.withValues(alpha: 0.2),
                      borderRadius: 999.circular,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryWhite,
                            shape: BoxShape.circle,
                          ),
                        ),
                        8.pw,
                        Text(
                          AppStrings.dashboardSafetyMonitorActiveBadge
                              .toUpperCase(),
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.ph,
                  Text(
                    controller.selectedSafetyMonitorType,
                    textAlign: TextAlign.center,
                    style: context.titleLargeStyle?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 32, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SafetyMonitorCurrentStatusCard(),
                    32.ph,
                    const SafetyMonitorRiskScoreCard(riskScore: _riskScore),
                    32.ph,
                    const SafetyMonitorActivityLogCard(),
                    32.ph,
                    GestureDetector(
                      onTap: controller.stopSafetyMonitoring,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        padding: AppInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.dashboardSosRed.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: 16.circular,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssetsSvg.dashboardSosActivatingCloseIcn,
                              width: 20.sp,
                              height: 20.sp,
                            ),
                            8.pw,
                            Text(
                              AppStrings.dashboardSafetyMonitorStopLabel,
                              style: context.labelMediumStyle?.copyWith(
                                fontSize: 16.sp,
                                height: 24 / 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.dashboardSosRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
