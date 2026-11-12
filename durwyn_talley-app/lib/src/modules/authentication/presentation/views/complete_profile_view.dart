import '../../../../components/image_source_sheet.dart';
import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/sign_in_labeled_field.dart';

class CompleteProfileView extends ConsumerWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);
    final profileAvatar = ref.watch(
      profileAvatarControllerProvider.select((c) => c.avatar),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: controller.completeProfileFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.completeProfileTitle,
                  style: context.headlineMediumStyle?.copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhite,
                  ),
                ),
                4.ph,
                Text(
                  AppStrings.completeProfileSubtitle,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
                24.ph,
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => ImageSourceSheet.show(
                          context,
                          isDark: true,
                          onPicked: controller.pickProfileAvatar,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 112.w,
                              height: 112.h,
                              decoration: BoxDecoration(
                                color: AppColors.otpFieldFill,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryWhite.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              child: profileAvatar == null
                                  ? Center(
                                      child: SvgPicture.asset(
                                        AppAssetsSvg
                                            .completeProfileAvatarPlaceholderIcn,
                                        width: 48.w,
                                        height: 48.h,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        profileAvatar,
                                        width: 112.w,
                                        height: 112.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.successGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppAssetsSvg.imageSourceCameraIcn,
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      12.ph,
                      Text(
                        AppStrings.completeProfileUploadPhoto,
                        style: context.bodySmallStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                ),
                24.ph,
                SignInLabeledField(
                  label: AppStrings.fullName,
                  controller: controller.fullNameController,
                  hintText: AppStrings.fullNameHint,
                  validator: AppValidators.validateFullName,
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
                  label: AppStrings.completeProfileEmergencyMessageLabel,
                  controller: controller.emergencyMessageController,
                  hintText: AppStrings.completeProfileEmergencyMessageHint,
                  textInputType: TextInputType.multiline,
                  maxLines: 4,
                  minLines: 4,
                ),
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.saveProfile,
                  text: AppStrings.completeProfileSaveButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
