import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/saved_recording_entity.dart';
import 'saved_recording_card.dart';
import 'saved_recordings_filter_chip.dart';

class SavedRecordingsListSection extends StatefulWidget {
  const SavedRecordingsListSection({super.key});

  @override
  State<SavedRecordingsListSection> createState() =>
      _SavedRecordingsListSectionState();
}

class _SavedRecordingsListSectionState
    extends State<SavedRecordingsListSection> {
  static const List<String> _filters = [
    AppStrings.dashboardSavedRecordingsFilterAll,
    AppStrings.dashboardSavedRecordingsFilterVideo,
    AppStrings.dashboardSavedRecordingsFilterAudio,
  ];

  static const List<SavedRecordingEntity> _recordings = [
    SavedRecordingEntity(
      icon: AppAssetsSvg.dashboardSavedRecordingsVideoIcn,
      iconColor: AppColors.dashboardQuickActionBlue,
      title: AppStrings.dashboardSavedRecordingsRecording1Title,
      date: AppStrings.dashboardSavedRecordingsRecording1Date,
      duration: AppStrings.dashboardSavedRecordingsRecording1Duration,
      size: AppStrings.dashboardSavedRecordingsRecording1Size,
      type: AppStrings.dashboardSavedRecordingsFilterVideo,
    ),
    SavedRecordingEntity(
      icon: AppAssetsSvg.dashboardSavedRecordingsMicIcn,
      iconColor: AppColors.dashboardQuickActionPurple,
      title: AppStrings.dashboardSavedRecordingsRecording2Title,
      date: AppStrings.dashboardSavedRecordingsRecording2Date,
      duration: AppStrings.dashboardSavedRecordingsRecording2Duration,
      size: AppStrings.dashboardSavedRecordingsRecording2Size,
      type: AppStrings.dashboardSavedRecordingsFilterAudio,
    ),
    SavedRecordingEntity(
      icon: AppAssetsSvg.dashboardSavedRecordingsVideoIcn,
      iconColor: AppColors.dashboardQuickActionBlue,
      title: AppStrings.dashboardSavedRecordingsRecording3Title,
      date: AppStrings.dashboardSavedRecordingsRecording3Date,
      duration: AppStrings.dashboardSavedRecordingsRecording3Duration,
      size: AppStrings.dashboardSavedRecordingsRecording3Size,
      type: AppStrings.dashboardSavedRecordingsFilterVideo,
    ),
  ];

  static const double _storageUsedProgress = 367 / 10240;

  String _selectedFilter = AppStrings.dashboardSavedRecordingsFilterAll;

  @override
  Widget build(BuildContext context) {
    final filteredRecordings = _selectedFilter == _filters.first
        ? _recordings
        : _recordings
              .where((recording) => recording.type == _selectedFilter)
              .toList();

    return Padding(
      padding: AppInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final filter in _filters) ...[
                SavedRecordingsFilterChip(
                  label: filter,
                  isSelected: _selectedFilter == filter,
                  onTap: () => setState(() => _selectedFilter = filter),
                ),
                if (filter != _filters.last) 8.pw,
              ],
            ],
          ),
          16.ph,
          Container(
            width: double.infinity,
            padding: AppInsets.all(17),
            decoration: BoxDecoration(
              color: AppColors.dashboardCardBg,
              borderRadius: 16.circular,
              border: Border.all(
                color: AppColors.primaryWhite.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.dashboardSavedRecordingsStorageUsedLabel,
                      style: context.bodySmallStyle?.copyWith(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.coolGray,
                      ),
                    ),
                    Text(
                      AppStrings.dashboardSavedRecordingsStorageUsedValue,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
                8.ph,
                ClipRRect(
                  borderRadius: 999.circular,
                  child: LinearProgressIndicator(
                    value: _storageUsedProgress,
                    minHeight: 8.h,
                    backgroundColor: AppColors.supportChatInputBg,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.successGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.ph,
          for (final recording in filteredRecordings) ...[
            SavedRecordingCard(recording: recording),
            16.ph,
          ],
          Container(
            width: double.infinity,
            padding: AppInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withValues(alpha: 0.1),
              borderRadius: 16.circular,
              border: Border.all(
                color: AppColors.successGreen.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.dashboardSavedRecordingsPremiumTitle,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.successGreen,
                  ),
                ),
                10.ph,
                Text(
                  AppStrings.dashboardSavedRecordingsPremiumSubtitle,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.successGreen.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
