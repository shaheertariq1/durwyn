import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_labeled_field.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 20),
          child: Form(
            key: controller.forgotPasswordFormKey,
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
                24.ph,
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.successGreen.withValues(alpha: 0.2),
                        ),
                        child: SvgPicture.asset(
                          AppAssetsSvg.forgotPasswordCheckIcn,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                      10.ph,
                      Text(
                        AppStrings.checkYourEmail,
                        textAlign: TextAlign.center,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      10.ph,
                      Text(
                        AppStrings.checkYourEmailSubtitle,
                        textAlign: TextAlign.center,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryWhite.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                24.ph,
                SignInLabeledField(
                  label: AppStrings.emailLabel,
                  controller: controller.forgotPasswordEmailController,
                  hintText: AppStrings.forgotPasswordEmailHint,
                  prefixIcon: AppAssetsSvg.signInMailIcn,
                  textInputType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmail,
                ),
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.sendResetLink,
                  text: AppStrings.sendResetLink,
                ),
                24.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryWhite.withValues(alpha: 0.1),
                    ),
                    borderRadius: 16.circular,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.whatsNext,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      8.ph,
                      Text(
                        AppStrings.whatsNextDescription,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryWhite.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                24.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.didntReceiveEmail,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    10.pw,
                    GestureDetector(
                      onTap: controller.sendResetLink,
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        AppStrings.resend,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen,
                        ),
                      ),
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
