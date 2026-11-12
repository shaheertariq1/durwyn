import '../../../../core/utils/app_exports.dart';

class NoHelpResults extends StatelessWidget {
  const NoHelpResults({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: AppInsets.symmetric(vertical: 40),
        child: Text(
          AppStrings.helpCenterNoResults,
          textAlign: TextAlign.center,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.coolGray,
          ),
        ),
      ),
    );
  }
}
