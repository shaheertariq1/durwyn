import '../../../../core/utils/app_exports.dart';

class ChoosePlanBackButton extends StatelessWidget {
  const ChoosePlanBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssetsSvg.choosePlanBackIcn,
            width: 20.w,
            height: 20.h,
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
    );
  }
}
