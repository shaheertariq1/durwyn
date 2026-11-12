import '../../../../components/custom_textfield.dart';
import '../../../../core/utils/app_exports.dart';

class UpdatePaymentField extends StatelessWidget {
  const UpdatePaymentField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.maxLength,
    required this.inputFormatters,
    this.contentPadding,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelSmallStyle?.copyWith(
            fontSize: 12.sp,
            height: 16 / 12,
            fontWeight: FontWeight.w500,
            color: AppColors.coolGray,
          ),
        ),
        10.ph,
        CustomTextField(
          controller: controller,
          hintText: hintText,
          textInputType: keyboardType,
          maxLength: maxLength,
          isObscure: obscureText,
          inputFormatters: inputFormatters,
          fillColor: AppColors.choosePlanNeutralChip,
          enableBorderColor: AppColors.primaryWhite.withValues(alpha: 0.1),
          focusedBorderColor: AppColors.successGreen,
          cursorColor: AppColors.successGreen,
          contentPadding: contentPadding ??
              AppInsets.symmetric(horizontal: 17, vertical: 13),
          hintTextStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.coolGray,
          ),
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhite,
          ),
        ),
      ],
    );
  }
}
