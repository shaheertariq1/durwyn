import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';

class SilentEmergencyView extends ConsumerWidget {
  const SilentEmergencyView({super.key});

  static const List<String> _whatHappensPoints = [
    AppStrings.dashboardSilentEmergencyPoint1,
    AppStrings.dashboardSilentEmergencyPoint2,
    AppStrings.dashboardSilentEmergencyPoint3,
    AppStrings.dashboardSilentEmergencyPoint4,
    AppStrings.dashboardSilentEmergencyPoint5,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: SingleChildScrollView(
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
                        AppStrings.dashboardEmergencySilentEmergencyTitle,
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
                      color: AppColors.dashboardQuickActionOrange,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssetsSvg.dashboardHomeSilentEmergencyIcn,
                      width: 48.sp,
                      height: 48.sp,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryWhite,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                24.ph,
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppStrings.dashboardSilentEmergencyHeading,
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
                    AppStrings.dashboardSilentEmergencySubtitle,
                    textAlign: TextAlign.center,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
                24.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardCardBg,
                    borderRadius: 16.circular,
                    border: Border.all(
                      color: AppColors.primaryWhite.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dashboardSilentEmergencyWhatHappensTitle,
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 18.sp,
                          height: 28 / 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      10.ph,
                      for (final point in _whatHappensPoints)
                        Padding(
                          padding: AppInsets.only(
                            bottom: point == _whatHappensPoints.last ? 0 : 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•',
                                style: context.bodyMediumStyle?.copyWith(
                                  fontSize: 16.sp,
                                  height: 24 / 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.successGreen,
                                ),
                              ),
                              12.pw,
                              Expanded(
                                child: Text(
                                  point,
                                  style: context.bodyMediumStyle?.copyWith(
                                    fontSize: 16.sp,
                                    height: 24 / 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                24.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardSosRed.withValues(alpha: 0.1),
                    borderRadius: 16.circular,
                    border: Border.all(
                      color: AppColors.dashboardSosRed.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    AppStrings.dashboardSilentEmergencyWarning,
                    style: context.bodySmallStyle?.copyWith(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.dashboardSosRed,
                    ),
                  ),
                ),
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.activateSilentEmergency,
                  text: AppStrings.dashboardSilentEmergencyActivateLabel,
                  backgroundColor: AppColors.dashboardQuickActionOrange,
                  style: TextStyle(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryWhite,
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
