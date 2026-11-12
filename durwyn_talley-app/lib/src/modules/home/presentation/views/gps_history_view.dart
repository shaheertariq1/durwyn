import '../../../../core/utils/app_exports.dart';
import '../widgets/gps_history_list_section.dart';

class GpsHistoryView extends StatelessWidget {
  const GpsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: AppInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: AppRouterGo.back,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssetsSvg.dashboardGpsHistoryBackIcn,
                              width: 20.sp,
                              height: 20.sp,
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
                      24.pw,
                      Text(
                        AppStrings.dashboardGpsHistoryTitle,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                24.ph,
                SizedBox(
                  height: 220.h,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppAssetsPng.dashboardGpsHistoryMapBg,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      ColoredBox(
                        color: AppColors.primaryblack.withValues(alpha: 0.4),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssetsSvg.dashboardGpsHistoryPinIcn,
                            width: 64.sp,
                            height: 64.sp,
                          ),
                          10.ph,
                          Container(
                            padding: AppInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.dashboardMapLabelBg,
                              borderRadius: 4.circular,
                            ),
                            child: Text(
                              AppStrings.dashboardGpsHistoryCurrentLocationLabel,
                              style: context.labelSmallStyle?.copyWith(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryWhite.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                16.ph,
                const GpsHistoryListSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
