import '../../../../core/utils/app_exports.dart';

class DeleteAllDataButton extends StatelessWidget {
  const DeleteAllDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppStrings.privacyControlsDeleteAllData,
      child: GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: 58.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: 16.circular,
            border: Border.all(
              width: 1.085,
              color: AppColors.dashboardSosRed,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssetsSvg.privacyControlsDeleteIcn,
                width: 20.w,
                height: 20.h,
              ),
              8.pw,
              Text(
                AppStrings.privacyControlsDeleteAllData,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dashboardSosRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
