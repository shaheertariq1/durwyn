import '../../../../components/custom_textfield.dart';
import '../../../../core/utils/app_exports.dart';

class ChangePasswordField extends StatelessWidget {
  const ChangePasswordField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isLast = false,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.coolGray,
          ),
        ),
        10.ph,
        CustomTextField(
          controller: controller,
          hintText: hintText,
          isObscure: true,
          isPrefix: true,
          prefixWidget: SvgPicture.asset(
            AppAssetsSvg.signInLockIcn,
            width: 20.w,
            height: 20.h,
          ),
          isSuffix: true,
          suffixIcon: AppAssetsSvg.signInEyeOffIcn,
          suffixIconVisible: AppAssetsSvg.signInEyeIcn,
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
          isLast: isLast,
          onFieldSubmitted: isLast ? (_) => _submit(context) : null,
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    Form.of(context).validate();
  }
}
