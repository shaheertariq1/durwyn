import '../../../../components/custom_textfield.dart';
import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';

class VerifyOtpView extends ConsumerWidget {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              24.ph,
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppStrings.verification,
                  textAlign: TextAlign.center,
                  style: context.headlineSmallStyle?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
              8.ph,
              SizedBox(
                width: double.infinity,
                child: Text(
                  controller.phoneNumberController.text.isNotEmpty
                      ? 'Enter the 6-digit verification code sent to ${controller.phoneNumberController.text.trim()}'
                      : AppStrings.verifyOtpSubtitle,
                  textAlign: TextAlign.center,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
              ),
              24.ph,
              Row(
                children: List.generate(controller.otpControllers.length, (
                  index,
                ) {
                  final isLast = index == controller.otpControllers.length - 1;
                  return Expanded(
                    child: Padding(
                      padding: AppInsets.only(right: isLast ? 0 : 12),
                      child: CustomTextField(
                        controller: controller.otpControllers[index],
                        focusNode: controller.otpFocusNodes[index],
                        textInputType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        isLast: isLast,
                        fillColor: AppColors.otpFieldFill,
                        enableBorderColor: AppColors.signInDarkBorder,
                        focusedBorderColor: AppColors.signInDarkBorder,
                        contentPadding: AppInsets.symmetric(vertical: 16),
                        fieldBorderRadius: 16,
                        textStyle: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) =>
                            controller.onOtpChanged(index, value),
                      ),
                    ),
                  );
                }),
              ),
              16.ph,
              GestureDetector(
                onTap: controller.canResendOtp ? controller.resendOtp : null,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    controller.canResendOtp
                        ? AppStrings.resendCode
                        : '${AppStrings.resendCodeInPrefix}'
                              '${controller.otpResendSeconds}s',
                    textAlign: TextAlign.center,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: controller.canResendOtp
                          ? FontWeight.w500
                          : FontWeight.w400,
                      color: controller.canResendOtp
                          ? AppColors.successGreen
                          : AppColors.coolGray,
                    ),
                  ),
                ),
              ),
              24.ph,
              PrimaryElevatedButton(
                onTap: controller.verifyAccount,
                text: AppStrings.verifyAccount,
                loader: controller.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
