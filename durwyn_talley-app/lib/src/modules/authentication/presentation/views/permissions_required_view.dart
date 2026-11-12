import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/permissions_required_card.dart';

class PermissionsRequiredView extends ConsumerWidget {
  const PermissionsRequiredView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.permissionsRequiredTitle,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              4.ph,
              Text(
                AppStrings.permissionsRequiredSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
              24.ph,
              PermissionsRequiredCard(
                title: AppStrings.permissionsRequiredLocationTitle,
                subtitle: AppStrings.permissionsRequiredLocationSubtitle,
                icon: AppAssetsSvg.permissionsRequiredGrantedCheckIcn,
                granted: controller.grantedPermissions.contains(
                  AppPermission.location,
                ),
                onGrant: () => controller.grantPermission(
                  AppPermission.location,
                ),
              ),
              16.ph,
              PermissionsRequiredCard(
                title: AppStrings.permissionsRequiredCameraTitle,
                subtitle: AppStrings.permissionsRequiredCameraSubtitle,
                icon: AppAssetsSvg.permissionsRequiredCameraIcn,
                granted: controller.grantedPermissions.contains(
                  AppPermission.camera,
                ),
                onGrant: () => controller.grantPermission(
                  AppPermission.camera,
                ),
              ),
              16.ph,
              PermissionsRequiredCard(
                title: AppStrings.permissionsRequiredMicrophoneTitle,
                subtitle: AppStrings.permissionsRequiredMicrophoneSubtitle,
                icon: AppAssetsSvg.permissionsRequiredMicrophoneIcn,
                granted: controller.grantedPermissions.contains(
                  AppPermission.microphone,
                ),
                onGrant: () => controller.grantPermission(
                  AppPermission.microphone,
                ),
              ),
              16.ph,
              PermissionsRequiredCard(
                title: AppStrings.permissionsRequiredNotificationsTitle,
                subtitle: AppStrings.permissionsRequiredNotificationsSubtitle,
                icon: AppAssetsSvg.permissionsRequiredNotificationIcn,
                granted: controller.grantedPermissions.contains(
                  AppPermission.notifications,
                ),
                onGrant: () => controller.grantPermission(
                  AppPermission.notifications,
                ),
              ),
              16.ph,
              PermissionsRequiredCard(
                title: AppStrings.permissionsRequiredBackgroundActivityTitle,
                subtitle:
                    AppStrings.permissionsRequiredBackgroundActivitySubtitle,
                icon: AppAssetsSvg.permissionsRequiredBackgroundActivityIcn,
                granted: controller.grantedPermissions.contains(
                  AppPermission.backgroundActivity,
                ),
                onGrant: () => controller.grantPermission(
                  AppPermission.backgroundActivity,
                ),
              ),
              24.ph,
              PrimaryElevatedButton(
                onTap: controller.finishPermissionsSetup,
                text: AppStrings.permissionsRequiredContinueButton,
              ),
              12.ph,
              Center(
                child: TextButton(
                  onPressed: controller.finishPermissionsSetup,
                  child: Text(
                    AppStrings.setUpLater,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
