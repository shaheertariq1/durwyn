import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';
import '../widgets/safety_monitor_type_option.dart';

class SafetyMonitorView extends ConsumerWidget {
  const SafetyMonitorView({super.key});

  static const Map<String, ({String icon, Color iconBg, String subtitle})>
      _typeConfig = {
    AppStrings.dashboardSafetyMonitorTravelTitle: (
      icon: AppAssetsSvg.dashboardSafetyMonitorTravelIcn,
      iconBg: AppColors.dashboardQuickActionBlue,
      subtitle: AppStrings.dashboardSafetyMonitorTravelSubtitle,
    ),
    AppStrings.dashboardSafetyMonitorActivityTitle: (
      icon: AppAssetsSvg.dashboardSafetyMonitorActivityIcn,
      iconBg: AppColors.dashboardQuickActionPurple,
      subtitle: AppStrings.dashboardSafetyMonitorActivitySubtitle,
    ),
    AppStrings.dashboardSafetyMonitorRiskTitle: (
      icon: AppAssetsSvg.dashboardSafetyMonitorRiskIcn,
      iconBg: AppColors.dashboardQuickActionOrange,
      subtitle: AppStrings.dashboardSafetyMonitorRiskSubtitle,
    ),
  };

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
                        AppStrings.dashboardSafetyMonitorTitle,
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
                      color: AppColors.dashboardQuickActionPurple,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssetsSvg.dashboardHomeSafetyMonitorIcn,
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
                    AppStrings.dashboardSafetyMonitorHeading,
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
                    AppStrings.dashboardSafetyMonitorSubtitle,
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
                for (final type in HomeController.safetyMonitorTypes)
                  Padding(
                    padding: AppInsets.only(
                      bottom: type == HomeController.safetyMonitorTypes.last
                          ? 0
                          : 16,
                    ),
                    child: SafetyMonitorTypeOption(
                      icon: _typeConfig[type]!.icon,
                      iconBg: _typeConfig[type]!.iconBg,
                      title: type,
                      subtitle: _typeConfig[type]!.subtitle,
                      selected: controller.selectedSafetyMonitorType == type,
                      onTap: () => controller.selectSafetyMonitorType(type),
                    ),
                  ),
                32.ph,
                PrimaryElevatedButton(
                  onTap: controller.enableSafetyMonitoring,
                  text: AppStrings.dashboardSafetyMonitorEnableLabel,
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
