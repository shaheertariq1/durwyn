import '../../../../core/utils/app_exports.dart';

class ChangePlanConfirmButton extends StatelessWidget {
  const ChangePlanConfirmButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.successGreen,
          borderRadius: 16.circular,
        ),
        child: Text(
          AppStrings.changePlanConfirm,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
            color: AppColors.dashboardBackground,
          ),
        ),
      ),
    );
  }
}
