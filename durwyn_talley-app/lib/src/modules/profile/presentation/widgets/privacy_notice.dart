import '../../../../core/utils/app_exports.dart';

class PrivacyNotice extends StatelessWidget {
  const PrivacyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dashboardProtectionBannerBg,
        borderRadius: 16.circular,
        border: Border.all(
          width: 1.085,
          color: AppColors.dashboardProtectionBannerBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.only(top: 2),
            child: SvgPicture.asset(
              AppAssetsSvg.privacyControlsShieldIcn,
              width: 20.w,
              height: 20.h,
            ),
          ),
          12.pw,
          Expanded(
            child: Text(
              AppStrings.privacyControlsNotice,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: AppColors.dashboardProtectionSubtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
