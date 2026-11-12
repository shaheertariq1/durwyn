import '../../../../core/utils/app_exports.dart';

class PasswordRequirementsCard extends StatelessWidget {
  const PasswordRequirementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          width: 1.085,
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssetsSvg.changePasswordLockIcn,
            width: 40.w,
            height: 40.h,
          ),
          16.pw,
          Expanded(
            child: Text(
              AppStrings.profileChangePasswordRequirements,
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
    );
  }
}
