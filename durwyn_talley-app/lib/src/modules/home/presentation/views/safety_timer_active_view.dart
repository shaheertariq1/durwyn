import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';

class SafetyTimerActiveView extends ConsumerWidget {
  const SafetyTimerActiveView({super.key});

  String _formatRemaining(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);
    final progress = controller.safetyTimerTotalSeconds == 0
        ? 0.0
        : controller.safetyTimerSecondsRemaining /
            controller.safetyTimerTotalSeconds;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: Padding(
            padding: AppInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.dashboardSafetyTimerActiveTitle,
                  textAlign: TextAlign.center,
                  style: context.headlineMediumStyle?.copyWith(
                    fontSize: 24.sp,
                    height: 32 / 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhite,
                  ),
                ),
                10.ph,
                Text(
                  AppStrings.dashboardSafetyTimerActiveSubtitle,
                  textAlign: TextAlign.center,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
                24.ph,
                SizedBox(
                  width: 256.w,
                  height: 256.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 256.w,
                        height: 256.h,
                        child: CircularProgressIndicator(
                          value: progress.clamp(0.0, 1.0),
                          strokeWidth: 8.w,
                          strokeCap: StrokeCap.round,
                          backgroundColor: AppColors.choosePlanNeutralChip,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.dashboardQuickActionBlue,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatRemaining(
                              controller.safetyTimerSecondsRemaining,
                            ),
                            style: context.headlineLargeStyle?.copyWith(
                              fontSize: 60.sp,
                              height: 1,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                          8.ph,
                          Text(
                            AppStrings.dashboardSafetyTimerRemainingLabel,
                            style: context.bodySmallStyle?.copyWith(
                              fontSize: 14.sp,
                              height: 20 / 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.coolGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.checkInSafetyTimer,
                  text: AppStrings.dashboardSafetyTimerCheckInLabel,
                  leadingWidget: SvgPicture.asset(
                    AppAssetsSvg.safetyTimerActiveCheckIcn,
                    width: 24.sp,
                    height: 24.sp,
                  ),
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dashboardBackground,
                  ),
                ),
                24.ph,
                GestureDetector(
                  onTap: controller.cancelSafetyTimer,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    padding: AppInsets.symmetric(vertical: 17),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.dashboardCardBg,
                      borderRadius: 16.circular,
                      border: Border.all(
                        width: 1.085,
                        color: AppColors.primaryWhite.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssetsSvg.dashboardSosActivatingCloseIcn,
                          width: 20.sp,
                          height: 20.sp,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        12.pw,
                        Text(
                          AppStrings.dashboardSafetyTimerCancelLabel,
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                24.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.choosePlanNeutralChip.withValues(
                      alpha: 0.5,
                    ),
                    borderRadius: 16.circular,
                  ),
                  child: Text(
                    AppStrings.dashboardSafetyTimerExpiryNotice,
                    textAlign: TextAlign.center,
                    style: context.bodySmallStyle?.copyWith(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
