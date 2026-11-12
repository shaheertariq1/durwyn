import '../../../../core/utils/app_exports.dart';

class HelpCenterHeader extends StatelessWidget {
  const HelpCenterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: AppRouterGo.back,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssetsSvg.helpCenterBackIcn,
                width: 20.w,
                height: 20.h,
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
        50.pw,
        Expanded(
          child: Text(
            AppStrings.dashboardProfileHelpCenter,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleLargeStyle?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ],
    );
  }
}
