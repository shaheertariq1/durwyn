import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import '../widgets/change_password_field.dart';
import '../widgets/change_password_header.dart';
import '../widgets/password_requirements_card.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
            child: Form(
              key: controller.changePasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChangePasswordHeader(),
                  24.ph,
                  const PasswordRequirementsCard(),
                  16.ph,
                  ChangePasswordField(
                    label: AppStrings.hotelCurrentPassword,
                    hintText: AppStrings.profileCurrentPasswordHint,
                    controller: controller.currentPasswordController,
                    validator: (value) => AppValidators.validatePass(
                      value,
                      'Please enter your current password',
                    ),
                  ),
                  16.ph,
                  ChangePasswordField(
                    label: AppStrings.newPassword,
                    hintText: AppStrings.confirmPasswordHint,
                    controller: controller.newPasswordController,
                    validator: AppValidators.validateNewPassword,
                  ),
                  16.ph,
                  ChangePasswordField(
                    label: AppStrings.confirmNewPassword,
                    hintText: AppStrings.confirmPasswordHint,
                    controller: controller.confirmNewPasswordController,
                    validator: (value) =>
                        AppValidators.validateConfirmNewPassword(
                      value,
                      controller.newPasswordController,
                    ),
                    isLast: true,
                  ),
                  16.ph,
                  PrimaryElevatedButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.updatePassword();
                    },
                    text: AppStrings.profileUpdatePassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
