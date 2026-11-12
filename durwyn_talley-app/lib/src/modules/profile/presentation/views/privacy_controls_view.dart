import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/settings_toggle_item_entity.dart';
import '../controller/profile_controller.dart';
import '../widgets/delete_all_data_button.dart';
import '../widgets/privacy_controls_header.dart';
import '../widgets/privacy_notice.dart';
import '../widgets/settings_toggle_card.dart';

class PrivacyControlsView extends ConsumerWidget {
  const PrivacyControlsView({super.key});

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
                const PrivacyControlsHeader(),
                24.ph,
                const PrivacyNotice(),
                16.ph,
                SettingsToggleCard(
                  items: [
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.privacyControlsLocationIcn,
                      title: AppStrings.privacyControlsLocationHistory,
                      subtitle:
                          AppStrings.privacyControlsLocationHistorySubtitle,
                      value: controller.storeLocationHistory,
                      onChanged: controller.toggleStoreLocationHistory,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.privacyControlsMicrophoneIcn,
                      title: AppStrings.privacyControlsAudioRecordings,
                      subtitle:
                          AppStrings.privacyControlsAudioRecordingsSubtitle,
                      value: controller.saveAudioRecordings,
                      onChanged: controller.toggleSaveAudioRecordings,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.privacyControlsAnalyticsIcn,
                      title: AppStrings.privacyControlsUsageAnalytics,
                      subtitle:
                          AppStrings.privacyControlsUsageAnalyticsSubtitle,
                      value: controller.shareUsageAnalytics,
                      onChanged: controller.toggleShareUsageAnalytics,
                    ),
                    SettingsToggleItemEntity(
                      icon: AppAssetsSvg.privacyControlsShieldIcn,
                      title: AppStrings.privacyControlsCrashReports,
                      subtitle: AppStrings.privacyControlsCrashReportsSubtitle,
                      value: controller.sendCrashReports,
                      onChanged: controller.toggleSendCrashReports,
                    ),
                  ],
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: controller.savePrivacySettings,
                  text: AppStrings.privacyControlsSave,
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dashboardBackground,
                  ),
                ),
                16.ph,
                const DeleteAllDataButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
