import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/settings_toggle_item_entity.dart';
import '../controller/profile_controller.dart';
import '../widgets/notification_settings_header.dart';
import '../widgets/settings_toggle_card.dart';

class NotificationSettingsView extends ConsumerWidget {
  const NotificationSettingsView({super.key});

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
                const NotificationSettingsHeader(),
                24.ph,
                SettingsToggleCard(
                  items: [
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.notificationSettingsEmergencyAlertIcn,
                      title: AppStrings.notificationSettingsEmergencyAlerts,
                      subtitle: AppStrings
                          .notificationSettingsEmergencyAlertsSubtitle,
                      value: controller.notifyEmergencyAlerts,
                      onChanged: controller.toggleEmergencyAlerts,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.notificationSettingsTimerReminderIcn,
                      title: AppStrings.notificationSettingsTimerReminders,
                      subtitle:
                          AppStrings.notificationSettingsTimerRemindersSubtitle,
                      value: controller.notifyTimerReminders,
                      onChanged: controller.toggleTimerReminders,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.notificationSettingsContactActivityIcn,
                      title: AppStrings.notificationSettingsContactActivity,
                      subtitle: AppStrings
                          .notificationSettingsContactActivitySubtitle,
                      value: controller.notifyContactActivity,
                      onChanged: controller.toggleContactActivity,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.notificationSettingsAppUpdatesIcn,
                      title: AppStrings.notificationSettingsAppUpdates,
                      subtitle:
                          AppStrings.notificationSettingsAppUpdatesSubtitle,
                      value: controller.notifyAppUpdates,
                      onChanged: controller.toggleAppUpdates,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.notificationSettingsWeeklyReportIcn,
                      title: AppStrings.notificationSettingsWeeklySafetyReports,
                      subtitle: AppStrings
                          .notificationSettingsWeeklySafetyReportsSubtitle,
                      value: controller.notifyWeeklySafetyReports,
                      onChanged: controller.toggleWeeklySafetyReports,
                    ),
                  ],
                ),
                16.ph,
                SettingsToggleCard(
                  items: [
                    SettingsToggleItemEntity(
                      title: AppStrings.notificationSettingsSilentHours,
                      subtitle:
                          AppStrings.notificationSettingsSilentHoursSubtitle,
                      value: controller.notifySilentHours,
                      onChanged: controller.toggleSilentHours,
                    ),
                  ],
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: controller.saveNotificationPreferences,
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
