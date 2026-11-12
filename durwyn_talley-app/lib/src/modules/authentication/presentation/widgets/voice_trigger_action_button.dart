import '../../../../core/utils/app_exports.dart';

class VoiceTriggerActionButton extends StatelessWidget {
  const VoiceTriggerActionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.otpFieldFill,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon!, width: 20.w, height: 20.h),
              8.pw,
            ],
            Text(
              text,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
