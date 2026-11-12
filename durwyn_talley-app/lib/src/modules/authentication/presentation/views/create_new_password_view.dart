import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_labeled_field.dart';

class CreateNewPasswordView extends ConsumerWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 20),
          child: Form(
            key: controller.createNewPasswordFormKey,
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
                          AppAssetsSvg.createNewPasswordUnlockIcn,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                      10.ph,
                      Text(
                        AppStrings.hotelCreateNewPasswordTitle,
                        textAlign: TextAlign.center,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      10.ph,
                      Text(
                        AppStrings.createNewPasswordSubtitle,
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
                  label: AppStrings.enterNewPassword,
                  controller: controller.newPasswordController,
                  hintText: AppStrings.enterNewPassword,
                  prefixIcon: AppAssetsSvg.signInLockIcn,
                  suffixIcon: AppAssetsSvg.signInEyeOffIcn,
                  suffixIconVisible: AppAssetsSvg.signInEyeIcn,
                  isObscure: true,
                  validator: AppValidators.validatePass,
                ),
                24.ph,
                SignInLabeledField(
                  label: AppStrings.confirmNewPasswordHint,
                  controller: controller.confirmNewPasswordController,
                  hintText: AppStrings.confirmNewPasswordHint,
                  prefixIcon: AppAssetsSvg.signInLockIcn,
                  suffixIcon: AppAssetsSvg.signInEyeOffIcn,
                  suffixIconVisible: AppAssetsSvg.signInEyeIcn,
                  isObscure: true,
                  validator: (value) => AppValidators.confirmPass(
                    value,
                    controller.newPasswordController,
                  ),
                ),
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.resetPassword,
                  text: AppStrings.resetPasswordButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
