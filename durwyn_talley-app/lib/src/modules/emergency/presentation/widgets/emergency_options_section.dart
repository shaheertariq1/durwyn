import '../../../../core/utils/app_exports.dart';
import '../../../home/presentation/controller/home_controller.dart';
import 'emergency_option_card.dart';

class EmergencyOptionsSection extends ConsumerWidget {
  const EmergencyOptionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dashboardEmergencyOptionsTitle,
          style: context.headlineMediumStyle?.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryWhite,
          ),
        ),
        4.ph,
        Text(
          AppStrings.dashboardEmergencyOptionsSubtitle,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.travellerMutedText,
          ),
        ),
        16.ph,
        EmergencyOptionCard(
          icon: AppAssetsSvg.dashboardEmergencySosIcn,
          title: AppStrings.dashboardEmergencySosTitle,
          subtitle: AppStrings.dashboardEmergencySosSubtitle,
          iconBg: AppColors.dashboardSosRed,
          onTap: () {
            ref.read(homeControllerProvider).startSosCountdown();
            AppRouterGo.push(sosActivationView);
          },
        ),
        16.ph,
        EmergencyOptionCard(
          icon: AppAssetsSvg.dashboardHomeSafetyTimerIcn,
          title: AppStrings.dashboardEmergencySafetyTimerTitle,
          subtitle: AppStrings.dashboardEmergencySafetyTimerSubtitle,
          iconBg: AppColors.dashboardQuickActionBlue,
          onTap: () => AppRouterGo.push(safetyTimerView),
        ),
        16.ph,
        EmergencyOptionCard(
          icon: AppAssetsSvg.dashboardHomeSafetyMonitorIcn,
          title: AppStrings.dashboardEmergencySafetyMonitorTitle,
          subtitle: AppStrings.dashboardEmergencySafetyMonitorSubtitle,
          iconBg: AppColors.dashboardQuickActionPurple,
          onTap: () => AppRouterGo.push(safetyMonitorView),
        ),
        16.ph,
        EmergencyOptionCard(
          icon: AppAssetsSvg.dashboardHomeSilentEmergencyIcn,
          title: AppStrings.dashboardEmergencySilentEmergencyTitle,
          subtitle: AppStrings.dashboardEmergencySilentEmergencySubtitle,
          iconBg: AppColors.dashboardQuickActionOrange,
          onTap: () => AppRouterGo.push(silentEmergencyView),
        ),
        16.ph,
        EmergencyOptionCard(
          icon: AppAssetsSvg.permissionsRequiredMicrophoneIcn,
          title: AppStrings.dashboardEmergencyVoiceTriggerTitle,
          subtitle: AppStrings.dashboardEmergencyVoiceTriggerSubtitle,
          iconBg: AppColors.dashboardQuickActionGreen,
          onTap: () => AppRouterGo.push(voiceTriggerSetupView),
        ),
      ],
    );
  }
}
