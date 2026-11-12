import '../../../../core/utils/app_exports.dart';
import '../widgets/saved_recordings_list_section.dart';

class SavedRecordingsView extends StatelessWidget {
  const SavedRecordingsView({super.key});

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
                        AppStrings.dashboardSavedRecordingsTitle,
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
                const SavedRecordingsListSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
