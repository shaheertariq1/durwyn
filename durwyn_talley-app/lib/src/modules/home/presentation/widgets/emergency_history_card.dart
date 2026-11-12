import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/emergency_history_entry_entity.dart';

class EmergencyHistoryCard extends StatelessWidget {
  const EmergencyHistoryCard({super.key, required this.entry});

  final EmergencyHistoryEntryEntity entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.primaryWhite.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: entry.iconColor,
                  borderRadius: 16.circular,
                ),
                child: SvgPicture.asset(
                  entry.icon,
                  width: 24.sp,
                  height: 24.sp,
                ),
              ),
              16.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 18.sp,
                        height: 28 / 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    4.ph,
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssetsSvg.dashboardEmergencyHistoryCalendarIcn,
                          width: 16.sp,
                          height: 16.sp,
                        ),
                        8.pw,
                        Expanded(
                          child: Text(
                            entry.date,
                            style: context.bodySmallStyle?.copyWith(
                              fontSize: 14.sp,
                              height: 20 / 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.coolGray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              8.pw,
              Text(
                entry.status,
                style: context.labelSmallStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: entry.statusColor,
                ),
              ),
            ],
          ),
          16.ph,
          Container(
            width: double.infinity,
            padding: AppInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _EmergencyHistoryStat(
                    label: AppStrings.dashboardEmergencyHistoryDurationLabel,
                    value: entry.duration,
                  ),
                ),
                Expanded(
                  child: _EmergencyHistoryStat(
                    label:
                        AppStrings.dashboardEmergencyHistoryContactsNotifiedLabel,
                    value: entry.contactsNotified,
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

class _EmergencyHistoryStat extends StatelessWidget {
  const _EmergencyHistoryStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodySmallStyle?.copyWith(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: AppColors.coolGray,
          ),
        ),
        Text(
          value,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
      ],
    );
  }
}
