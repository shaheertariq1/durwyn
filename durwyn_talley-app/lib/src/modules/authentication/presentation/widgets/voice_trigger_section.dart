import '../../../../core/utils/app_exports.dart';
import 'record_phrase_button.dart';

class VoiceTriggerSection extends StatelessWidget {
  const VoiceTriggerSection({
    super.key,
    required this.title,
    required this.isRecording,
    required this.isRecorded,
    required this.onTap,
  });

  final String title;
  final bool isRecording;
  final bool isRecorded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite.withValues(alpha: 0.6),
          ),
        ),
        RecordPhraseButton(
          active: isRecording || isRecorded,
          onTap: onTap,
          label: isRecording
              ? AppStrings.voiceTriggerRecordingLabel
              : (isRecorded
                    ? AppStrings.voiceTriggerRecordedLabel
                    : AppStrings.voiceTriggerRecordLabel),
          subtitle: isRecording
              ? AppStrings.voiceTriggerRecordingSubtitle
              : (isRecorded
                    ? AppStrings.voiceTriggerRecordedSubtitle
                    : AppStrings.voiceTriggerRecordSubtitle),
        ),
      ],
    );
  }
}
