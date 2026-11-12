import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_labeled_field.dart';

class CreateAccountView extends ConsumerWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Form(
            key: controller.createAccountFormKey,
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
                      AppStrings.personalInformation,
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
                          color: AppColors.primaryWhite.withValues(alpha: 0.1),
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
                          label: AppStrings.fullName,
                          controller: controller.fullNameController,
                          hintText: AppStrings.fullNameHint,
                          validator: AppValidators.validateFullName,
                        ),
                        16.ph,
                        SignInLabeledField(
                          label: AppStrings.emailAddress,
                          controller: controller.createAccountEmailController,
                          hintText: AppStrings.emailHint,
                          textInputType: TextInputType.emailAddress,
                          validator: AppValidators.validateEmail,
                        ),
                        16.ph,
                        SignInLabeledField(
                          label: AppStrings.phoneNumber,
                          controller: controller.phoneNumberController,
                          hintText: AppStrings.phoneHint,
                          helperText: AppStrings.phoneInstruction,
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                          ],
                          validator: AppValidators.validatePhoneNumber,
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryElevatedButton(
                  onTap: controller.continueCreateAccount,
                  text: AppStrings.continueButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
