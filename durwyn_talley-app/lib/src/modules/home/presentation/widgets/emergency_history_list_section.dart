import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/emergency_history_entry_entity.dart';
import 'emergency_history_card.dart';
import 'emergency_history_filter_chip.dart';

class EmergencyHistoryListSection extends StatefulWidget {
  const EmergencyHistoryListSection({super.key});

  @override
  State<EmergencyHistoryListSection> createState() =>
      _EmergencyHistoryListSectionState();
}

class _EmergencyHistoryListSectionState
    extends State<EmergencyHistoryListSection> {
  static const List<String> _filters = [
    AppStrings.dashboardEmergencyHistoryFilterAll,
    AppStrings.dashboardEmergencyHistoryFilterActive,
    AppStrings.dashboardEmergencyHistoryFilterResolved,
    AppStrings.dashboardEmergencyHistoryFilterCancelled,
  ];

  static const List<EmergencyHistoryEntryEntity> _entries = [
    EmergencyHistoryEntryEntity(
      icon: AppAssetsSvg.dashboardEmergencyHistorySosIcn,
      iconColor: AppColors.successGreen,
      title: AppStrings.dashboardEmergencyHistorySosAlertTitle,
      date: AppStrings.dashboardEmergencyHistorySosAlertDate,
      status: AppStrings.dashboardEmergencyHistoryFilterResolved,
      statusColor: AppColors.successGreen,
      duration: AppStrings.dashboardEmergencyHistorySosAlertDuration,
      contactsNotified: AppStrings.dashboardEmergencyHistorySosAlertContacts,
    ),
    EmergencyHistoryEntryEntity(
      icon: AppAssetsSvg.dashboardEmergencyHistoryCheckIcn,
      iconColor: AppColors.dashboardQuickActionBlue,
      title: AppStrings.dashboardEmergencySafetyTimerTitle,
      date: AppStrings.dashboardEmergencyHistorySafetyTimerDate,
      status: AppStrings.dashboardEmergencyHistoryStatusCompleted,
      statusColor: AppColors.dashboardQuickActionBlue,
      duration: AppStrings.dashboardEmergencyHistorySafetyTimerDuration,
      contactsNotified:
          AppStrings.dashboardEmergencyHistorySafetyTimerContacts,
    ),
    EmergencyHistoryEntryEntity(
      icon: AppAssetsSvg.dashboardEmergencyHistoryCancelIcn,
      iconColor: AppColors.dashboardSosRed,
      title: AppStrings.dashboardEmergencyVoiceTriggerTitle,
      date: AppStrings.dashboardEmergencyHistoryVoiceTriggerDate,
      status: AppStrings.dashboardEmergencyHistoryFilterCancelled,
      statusColor: AppColors.dashboardSosRed,
      duration: AppStrings.dashboardEmergencyHistoryVoiceTriggerDuration,
      contactsNotified:
          AppStrings.dashboardEmergencyHistoryVoiceTriggerContacts,
    ),
  ];

  String _selectedFilter = AppStrings.dashboardEmergencyHistoryFilterAll;

  @override
  Widget build(BuildContext context) {
    final filteredEntries = _selectedFilter == _filters.first
        ? _entries
        : _entries.where((entry) => entry.status == _selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: AppInsets.only(left: 32),
          child: Row(
            children: [
              for (final filter in _filters) ...[
                EmergencyHistoryFilterChip(
                  label: filter,
                  isSelected: _selectedFilter == filter,
                  onTap: () => setState(() => _selectedFilter = filter),
                ),
                if (filter != _filters.last) 8.pw,
              ],
            ],
          ),
        ),
        24.ph,
        Padding(
          padding: AppInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              for (var i = 0; i < filteredEntries.length; i++) ...[
                EmergencyHistoryCard(entry: filteredEntries[i]),
                if (i != filteredEntries.length - 1) 16.ph,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
