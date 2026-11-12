import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/settings_toggle_item_entity.dart';
import '../controller/profile_controller.dart';
import '../widgets/countdown_duration_card.dart';
import '../widgets/emergency_preferences_header.dart';
import '../widgets/settings_toggle_card.dart';

class EmergencyPreferencesView extends ConsumerWidget {
  const EmergencyPreferencesView({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EmergencyPreferencesHeader(),
                24.ph,
                SettingsToggleCard(
                  items: [
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.emergencyPreferencesAutoCallIcn,
                      title: AppStrings.emergencyPreferencesAutoCallTitle,
                      subtitle: AppStrings.emergencyPreferencesAutoCallSubtitle,
                      value: controller.autoCallEmergencyServices,
                      onChanged: controller.toggleAutoCallEmergencyServices,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.emergencyPreferencesGpsIcn,
                      title: AppStrings.emergencyPreferencesShareGpsTitle,
                      subtitle: AppStrings.emergencyPreferencesShareGpsSubtitle,
                      value: controller.shareGpsLocation,
                      onChanged: controller.toggleShareGpsLocation,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.emergencyPreferencesSmsIcn,
                      title: AppStrings.emergencyPreferencesSmsTitle,
                      subtitle: AppStrings.emergencyPreferencesSmsSubtitle,
                      value: controller.sendSmsAlerts,
                      onChanged: controller.toggleSendSmsAlerts,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.emergencyPreferencesAlarmIcn,
                      title: AppStrings.emergencyPreferencesAlarmTitle,
                      subtitle: AppStrings.emergencyPreferencesAlarmSubtitle,
                      value: controller.playAlarmSound,
                      onChanged: controller.togglePlayAlarmSound,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.emergencyPreferencesNotifyAllIcn,
                      title: AppStrings.emergencyPreferencesNotifyAllTitle,
                      subtitle:
                          AppStrings.emergencyPreferencesNotifyAllSubtitle,
                      value: controller.notifyAllContacts,
                      onChanged: controller.toggleNotifyAllContacts,
                    ),
                  ],
                ),
                16.ph,
                CountdownDurationCard(
                  value: controller.emergencyCountdownDuration,
                  options: ProfileController.emergencyCountdownOptions,
                  onChanged: controller.selectEmergencyCountdownDuration,
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: controller.saveEmergencyPreferences,
                  text: AppStrings.savePreferences,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dashboardBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
