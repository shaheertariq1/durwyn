import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_header.dart';
import '../widgets/sign_in_labeled_field.dart';
import '../widgets/sign_in_social_button.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 20),
          child: Form(
            key: controller.signInFormKey,
            child: Column(
              children: [
                const SignInHeader(),
                24.ph,
                SignInLabeledField(
                  label: AppStrings.signInEmailPhoneLabel,
                  controller: controller.signInEmailController,
                  hintText: AppStrings.signInEmailHint,
                  prefixIcon: AppAssetsSvg.signInMailIcn,
                  textInputType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmailOrPhone,
                ),
                16.ph,
                SignInLabeledField(
                  label: AppStrings.password,
                  controller: controller.signInPasswordController,
                  hintText: AppStrings.password,
                  prefixIcon: AppAssetsSvg.signInLockIcn,
                  suffixIcon: AppAssetsSvg.signInEyeOffIcn,
                  suffixIconVisible: AppAssetsSvg.signInEyeIcn,
                  isObscure: true,
                  validator: AppValidators.validatePass,
                ),
                16.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: controller.toggleRememberMe,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              borderRadius: 4.circular,
                              color: controller.rememberMe
                                  ? AppColors.successGreen
                                  : AppColors.transparent,
                              border: Border.all(
                                color: controller.rememberMe
                                    ? AppColors.successGreen
                                    : AppColors.primaryWhite,
                              ),
                            ),
                            child: controller.rememberMe
                                ? Icon(
                                    Icons.check,
                                    size: 12.sp,
                                    color: AppColors.splashScrimColor,
                                  )
                                : null,
                          ),
                          8.pw,
                          Text(
                            AppStrings.rememberMe,
                            style: context.labelMediumStyle?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.goToForgotPassword,
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        AppStrings.forgotPassword,
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: controller.signIn,
                  text: AppStrings.signIn,
                  loader: controller.isLoading,
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: controller.goToCreateAccount,
                  text: AppStrings.createAccount,
                  backgroundColor: AppColors.transparent,
                  textColor: AppColors.primaryWhite,
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                    elevation: 0,
                    side: BorderSide(
                      color: AppColors.primaryWhite.withValues(alpha: 0.1),
                      width: 1.088,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: 16.circular,
                    ),
                  ),
                ),
                24.ph,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.primaryWhite.withValues(alpha: 0.2),
                      ),
                    ),
                    Padding(
                      padding: AppInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.or.toLowerCase(),
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryWhite.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.primaryWhite.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
                24.ph,
                Row(
                  children: [
                    SignInSocialButton(
                      icon: AppAssetsSvg.signInGoogleIcn,
                      label: AppStrings.google,
                      onTap: () {},
                    ),
                    16.pw,
                    SignInSocialButton(
                      icon: AppAssetsSvg.signInAppleIcn,
                      label: AppStrings.apple,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
