import '../../../../core/utils/app_exports.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouterGo.pushRemoveUntil(signInView),
      child: Container(
        width: double.infinity,
        padding: AppInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.dashboardSosRed.withValues(alpha: 0.1),
          borderRadius: 16.circular,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssetsSvg.dashboardProfileLogoutIcn,
              width: 20.sp,
              height: 20.sp,
            ),
            8.pw,
            Text(
              AppStrings.dashboardProfileLogout,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.dashboardSosRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
