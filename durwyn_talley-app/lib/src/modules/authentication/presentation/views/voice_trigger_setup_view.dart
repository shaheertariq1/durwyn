import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/example_phrase_chip.dart';
import '../widgets/record_phrase_button.dart';
import '../widgets/sign_in_labeled_field.dart';
import '../widgets/voice_trigger_action_button.dart';
import '../widgets/voice_trigger_section.dart';
import '../widgets/waveform_playback_row.dart';

class VoiceTriggerSetupView extends ConsumerWidget {
  const VoiceTriggerSetupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);
    final isRecorded = controller.isEmergencyPhraseRecorded;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
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
              Text(
                AppStrings.voiceTriggerSetupTitle,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              4.ph,
              Text(
                AppStrings.voiceTriggerSetupSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
              24.ph,
              SignInLabeledField(
                label: AppStrings.voiceTriggerPhraseLabel,
                controller: controller.emergencyPhraseController,
                hintText: AppStrings.voiceTriggerPhraseHint,
                onChanged: controller.onEmergencyPhraseChanged,
              ),
              16.ph,
              if (isRecorded) ...[
                WaveformPlaybackRow(
                  isPlaying: controller.isTestingEmergencyPhrase,
                  onTap: controller.testEmergencyPhrase,
                ),
                10.ph,
                VoiceTriggerActionButton(
                  text: controller.isTestingEmergencyPhrase
                      ? AppStrings.voiceTriggerTestPhrasePlayingButton
                      : AppStrings.voiceTriggerTestPhraseButton,
                  onTap: controller.testEmergencyPhrase,
                ),
                10.ph,
                VoiceTriggerActionButton(
                  text: AppStrings.voiceTriggerResetPhraseButton,
                  icon: AppAssetsSvg.voiceTriggerResetIcn,
                  onTap: controller.resetEmergencyPhrase,
                ),
                24.ph,
                VoiceTriggerSection(
                  title: AppStrings.voiceTriggerSafetyMonitorLabel,
                  isRecording:
                      controller.recordingVoiceTrigger ==
                      VoiceTriggerType.safetyMonitor,
                  isRecorded: controller.recordedVoiceTriggers.contains(
                    VoiceTriggerType.safetyMonitor,
                  ),
                  onTap: () => controller.toggleVoiceTriggerRecording(
                    VoiceTriggerType.safetyMonitor,
                  ),
                ),
                VoiceTriggerSection(
                  title: AppStrings.voiceTriggerSilentEmergencyLabel,
                  isRecording:
                      controller.recordingVoiceTrigger ==
                      VoiceTriggerType.silentEmergency,
                  isRecorded: controller.recordedVoiceTriggers.contains(
                    VoiceTriggerType.silentEmergency,
                  ),
                  onTap: () => controller.toggleVoiceTriggerRecording(
                    VoiceTriggerType.silentEmergency,
                  ),
                ),
                VoiceTriggerSection(
                  title: AppStrings.voiceTriggerSilentTimerLabel,
                  isRecording:
                      controller.recordingVoiceTrigger ==
                      VoiceTriggerType.silentTimer,
                  isRecorded: controller.recordedVoiceTriggers.contains(
                    VoiceTriggerType.silentTimer,
                  ),
                  onTap: () => controller.toggleVoiceTriggerRecording(
                    VoiceTriggerType.silentTimer,
                  ),
                ),
              ] else ...[
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      AppStrings.voiceTriggerExamplesLabel,
                      style: context.bodySmallStyle?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.coolGray,
                      ),
                    ),
                    ExamplePhraseChip(
                      label: AppStrings.voiceTriggerExampleHelpMe,
                      onTap: () => controller.selectEmergencyPhraseExample(
                        AppStrings.voiceTriggerExampleHelpMe,
                      ),
                    ),
                    ExamplePhraseChip(
                      label: AppStrings.voiceTriggerExampleEmergencyNow,
                      onTap: () => controller.selectEmergencyPhraseExample(
                        AppStrings.voiceTriggerExampleEmergencyNow,
                      ),
                    ),
                    ExamplePhraseChip(
                      label: AppStrings.voiceTriggerExampleNeedAssistance,
                      onTap: () => controller.selectEmergencyPhraseExample(
                        AppStrings.voiceTriggerExampleNeedAssistance,
                      ),
                    ),
                  ],
                ),
                RecordPhraseButton(
                  active: controller.isRecordingEmergencyPhrase,
                  onTap: controller.recordEmergencyPhrase,
                  label: controller.isRecordingEmergencyPhrase
                      ? AppStrings.voiceTriggerRecordingLabel
                      : AppStrings.voiceTriggerRecordLabel,
                  subtitle: controller.isRecordingEmergencyPhrase
                      ? AppStrings.voiceTriggerRecordingSubtitle
                      : AppStrings.voiceTriggerRecordSubtitle,
                ),
              ],
              PrimaryElevatedButton(
                onTap: controller.completeVoiceTriggerSetup,
                text: AppStrings.voiceTriggerCompleteButton,
                enabled: controller.isVoiceTriggerSetupComplete,
              ),
              24.ph,
              Center(
                child: GestureDetector(
                  onTap: controller.skipVoiceTriggerSetup,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    AppStrings.voiceTriggerSkipButton,
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
