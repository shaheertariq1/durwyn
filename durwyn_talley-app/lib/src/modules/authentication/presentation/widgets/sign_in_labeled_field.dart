import '../../../../components/custom_textfield.dart';
import '../../../../core/utils/app_exports.dart';

class SignInLabeledField extends StatelessWidget {
  const SignInLabeledField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.isObscure = false,
    this.suffixIcon,
    this.suffixIconVisible,
    this.textInputType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.inputFormatters,
    this.helperText,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final bool isObscure;
  final String? suffixIcon;
  final String? suffixIconVisible;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? helperText;

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
            color: AppColors.signInFieldLabel,
          ),
        ),
        10.ph,
        CustomTextField(
          controller: controller,
          hintText: hintText,
          textInputType: textInputType,
          isObscure: isObscure,
          maxLines: maxLines,
          minLines: minLines,
          isPrefix: prefixIcon != null,
          prefixWidget: prefixIcon == null
              ? null
              : SvgPicture.asset(prefixIcon!, width: 20.w, height: 20.h),
          isSuffix: suffixIcon != null,
          suffixIcon: suffixIcon,
          suffixIconVisible: suffixIconVisible,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          fillColor: AppColors.transparent,
          enableBorderColor: AppColors.primaryWhite.withValues(alpha: 0.2),
          focusedBorderColor: AppColors.primaryWhite.withValues(alpha: 0.2),
          contentPadding: AppInsets.symmetric(horizontal: 12, vertical: 16),
          hintTextStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhite.withValues(alpha: 0.6),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhite,
          ),
          validator: validator,
        ),
        if (helperText != null) ...[
          6.ph,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 13.sp,
                color: AppColors.primaryWhite.withValues(alpha: 0.5),
              ),
              6.pw,
              Expanded(
                child: Text(
                  helperText!,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.primaryWhite.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
