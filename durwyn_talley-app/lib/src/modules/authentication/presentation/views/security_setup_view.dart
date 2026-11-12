import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_labeled_field.dart';

class SecuritySetupView extends ConsumerWidget {
  const SecuritySetupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Form(
            key: controller.securitySetupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: AppRouterGo.back,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20.sp,
                            color: AppColors.primaryWhite,
                          ),
                          8.pw,
                          Text(
                            AppStrings.back,
                            style: context.labelMediumStyle?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    30.pw,
                    Text(
                      AppStrings.securitySetup,
                      style: context.headlineSmallStyle?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
                16.ph,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.successGreen,
                          borderRadius: 100.circular,
                        ),
                      ),
                    ),
                    8.pw,
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.successGreen,
                          borderRadius: 100.circular,
                        ),
                      ),
                    ),
                  ],
                ),
                40.ph,
                Center(
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    padding: AppInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppAssetsPng.onboardingShieldLogo,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                40.ph,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SignInLabeledField(
                          label: AppStrings.password,
                          controller: controller.securitySetupPasswordController,
                          hintText: AppStrings.enterNewPassword,
                          prefixIcon: AppAssetsSvg.signInLockIcn,
                          suffixIcon: AppAssetsSvg.signInEyeOffIcn,
                          suffixIconVisible: AppAssetsSvg.signInEyeIcn,
                          isObscure: true,
                          validator: AppValidators.validatePass,
                        ),
                        16.ph,
                        SignInLabeledField(
                          label: AppStrings.confirmPassword,
                          controller:
                              controller.securitySetupConfirmPasswordController,
                          hintText: AppStrings.confirmPasswordHint,
                          prefixIcon: AppAssetsSvg.signInLockIcn,
                          suffixIcon: AppAssetsSvg.signInEyeOffIcn,
                          suffixIconVisible: AppAssetsSvg.signInEyeIcn,
                          isObscure: true,
                          validator: (value) => AppValidators.confirmPass(
                            value,
                            controller.securitySetupPasswordController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryElevatedButton(
                  onTap: controller.continueSecuritySetup,
                  text: AppStrings.continueButton,
                  loader: controller.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
