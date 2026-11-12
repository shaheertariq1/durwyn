import '../../../../core/utils/app_exports.dart';

class HelpSearchField extends StatelessWidget {
  const HelpSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.primaryWhite,
      style: context.bodyMediumStyle?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryWhite,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: AppStrings.helpCenterSearchHint,
        hintStyle: context.bodyMediumStyle?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.coolGray,
        ),
        prefixIcon: Padding(
          padding: AppInsets.only(left: 17, right: 16),
          child: SvgPicture.asset(
            AppAssetsSvg.helpCenterSearchIcn,
            width: 20.w,
            height: 20.h,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 53.w, minHeight: 20.h),
        contentPadding: AppInsets.symmetric(vertical: 13),
        filled: true,
        fillColor: AppColors.dashboardCardBg,
        enabledBorder: OutlineInputBorder(
          borderRadius: 16.circular,
          borderSide: BorderSide(
            width: 1.085,
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: 16.circular,
          borderSide: BorderSide(
            width: 1.085,
            color: AppColors.primaryWhite.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}
