import '../../../../components/custom_textfield.dart';
import '../../../../core/utils/app_exports.dart';

class PaymentField extends StatelessWidget {
  const PaymentField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.obscureText = false,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.coolGray,
          ),
        ),
        10.ph,
        CustomTextField(
          controller: controller,
          focusNode: focusNode,
          hintText: hintText,
          textInputType: keyboardType,
          maxLength: maxLength,
          isObscure: obscureText,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          fillColor: AppColors.choosePlanNeutralChip,
          enableBorderColor: AppColors.primaryWhite.withValues(alpha: 0.1),
          focusedBorderColor: AppColors.successGreen,
          cursorColor: AppColors.successGreen,
          contentPadding: AppInsets.symmetric(horizontal: 17, vertical: 14),
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
