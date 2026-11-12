import '../../../../core/utils/app_exports.dart';

class ManageSubscriptionHeader extends StatelessWidget {
  const ManageSubscriptionHeader({super.key});

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
                AppAssetsSvg.choosePlanBackIcn,
                width: 20.sp,
                height: 20.sp,
              ),
              8.pw,
              Text(
                AppStrings.back,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ),
        30.pw,
        Expanded(
          child: Text(
            AppStrings.dashboardProfileManageSubscription,
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
