import '../../../../core/utils/app_exports.dart';

class SignInSocialButton extends StatelessWidget {
  const SignInSocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: AppInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: 16.circular,
            border: Border.all(
              color: AppColors.primaryWhite.withValues(alpha: 0.2),
              width: 1.085,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon, width: 24.w, height: 24.h),
              16.pw,
              Text(
                label,
                style: context.labelLargeStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
