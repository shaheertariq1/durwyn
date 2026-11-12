import '../../../../components/image_source_sheet.dart';
import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';
import '../controller/profile_controller.dart';
import '../../../authentication/presentation/widgets/sign_in_labeled_field.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);
    final user = ref.watch(authenticationControllerProvider).currentUser;

    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: controller.editProfileFormKey,
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
                      AppStrings.dashboardProfileEditProfile,
                      style: context.titleLargeStyle?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
                32.ph,
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
                            UserAvatar(
                              size: 112.w,
                              fullName: user?.fullName,
                              avatarUrl: user?.avatarUrl,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.dashboardCardBg,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.dashboardBackground,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  AppAssetsSvg.imageSourceCameraIcn,
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primaryWhite,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.ph,
                      Text(
                        AppStrings.editProfileChangePhoto,
                        style: context.bodySmallStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                ),
                32.ph,
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
                  controller: controller.emailController,
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
                  maxLines: 6,
                  minLines: 6,
                ),
                32.ph,
                PrimaryElevatedButton(
                  onTap: controller.saveChanges,
                  text: AppStrings.saveChanges,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
