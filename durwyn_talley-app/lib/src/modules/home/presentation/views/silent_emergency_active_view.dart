import '../../../../core/utils/app_exports.dart';

class SilentEmergencyActiveView extends StatelessWidget {
  const SilentEmergencyActiveView({super.key});

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: 96.w,
                  height: 96.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.dashboardHomeSilentEmergencyIcn,
                    width: 48.sp,
                    height: 48.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.dashboardBackground,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                24.ph,
                Text(
                  AppStrings.dashboardSilentEmergencyActivatedTitle,
                  textAlign: TextAlign.center,
                  style: context.headlineMediumStyle?.copyWith(
                    fontSize: 30.sp,
                    height: 36 / 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhite,
                  ),
                ),
                10.ph,
                Text(
                  AppStrings.dashboardSilentEmergencyActivatedSubtitle,
                  textAlign: TextAlign.center,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
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
