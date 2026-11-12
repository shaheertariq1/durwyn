import '../../../../core/utils/app_exports.dart';

class PaymentMethodOptionButton extends StatelessWidget {
  const PaymentMethodOptionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.tintIcon = true,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool tintIcon;

  @override
  Widget build(BuildContext context) {
    final iconColor = selected
        ? AppColors.splashScrimColor
        : AppColors.primaryWhite;

    return PrimaryElevatedButton(
      onTap: onTap,
      text: label,
      backgroundColor: selected
          ? AppColors.successGreen
          : AppColors.otpFieldFill,
      textColor: iconColor,
      leadingWidget: SvgPicture.asset(
        icon,
        width: 20.w,
        height: 20.h,
        colorFilter: tintIcon
            ? ColorFilter.mode(iconColor, BlendMode.srcIn)
            : null,
      ),
      buttonStyle: selected
          ? null
          : ElevatedButton.styleFrom(
              backgroundColor: AppColors.otpFieldFill,
              elevation: 0,
              side: BorderSide(
                color: AppColors.primaryWhite.withValues(alpha: 0.1),
                width: 1.088,
              ),
              shape: RoundedRectangleBorder(borderRadius: 16.circular),
            ),
    );
  }
}
