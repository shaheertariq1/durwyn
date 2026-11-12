import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';
import '../widgets/safety_timer_duration_option.dart';

class SafetyTimerView extends ConsumerWidget {
  const SafetyTimerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: Padding(
            padding: AppInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: AppRouterGo.back,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20.sp,
                            color: AppColors.primaryWhite,
                          ),
                          8.pw,
                          Text(
                            AppStrings.back,
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
                    Expanded(
                      child: Text(
                        AppStrings.dashboardSafetyTimerTitle,
                        textAlign: TextAlign.center,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                    56.pw,
                  ],
                ),
                32.ph,
                Center(
                  child: Container(
                    width: 96.w,
                    height: 96.h,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.dashboardQuickActionBlue,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssetsSvg.dashboardHomeSafetyTimerIcn,
                      width: 48.sp,
                      height: 48.sp,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                32.ph,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppStrings.dashboardSafetyTimerHeading,
                    textAlign: TextAlign.center,
                    style: context.headlineMediumStyle?.copyWith(
                      fontSize: 30.sp,
                      height: 36 / 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
                10.ph,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppStrings.dashboardSafetyTimerSubtitle,
                    textAlign: TextAlign.center,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.travellerMutedText,
                    ),
                  ),
                ),
                32.ph,
                for (final option in HomeController.safetyTimerDurationOptions)
                  Padding(
                    padding: AppInsets.only(
                      bottom:
                          option == HomeController.safetyTimerDurationOptions.last
                              ? 0
                              : 16,
                    ),
                    child: SafetyTimerDurationOption(
                      label: option,
                      selected: controller.selectedSafetyTimerDuration ==
                          option,
                      onTap: () =>
                          controller.selectSafetyTimerDuration(option),
                    ),
                  ),
                32.ph,
                PrimaryElevatedButton(
                  onTap: controller.startSafetyTimer,
                  text: AppStrings.dashboardSafetyTimerStartLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dashboardBackground,
                  ),
                ),
                16.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
