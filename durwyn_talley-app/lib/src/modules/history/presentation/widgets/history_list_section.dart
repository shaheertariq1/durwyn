import '../../../../core/utils/app_exports.dart';
import '../controller/history_controller.dart';
import 'incident_card.dart';

class HistoryListSection extends ConsumerStatefulWidget {
  const HistoryListSection({super.key});

  @override
  ConsumerState<HistoryListSection> createState() => _HistoryListSectionState();
}

class _HistoryListSectionState extends ConsumerState<HistoryListSection> {
  int? _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final historyController = ref.watch(historyControllerProvider);
    final plan = ref.watch(subscriptionControllerProvider).currentPlan;
    final incidents = historyController.incidents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      Text(
                        AppStrings.dashboardHistoryTitle,
                        style: context.headlineMediumStyle?.copyWith(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      Container(
                        padding: AppInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.dashboardQuickActionBlue.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: 8.circular,
                          border: Border.all(
                            color: AppColors.dashboardQuickActionBlue.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Text(
                          plan == SubscriptionPlan.free
                              ? '3-Day Retention'
                              : '${plan.evidenceRetentionDays}-Day Retention',
                          style: context.labelSmallStyle?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dashboardQuickActionBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.ph,
                  Text(
                    plan == SubscriptionPlan.free
                        ? 'Showing emergency events from the past 3 days.'
                        : AppStrings.dashboardHistorySubtitle,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.coolGray,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => ref
                  .read(historyControllerProvider)
                  .fetchHistory(showLoading: true),
              icon: Icon(
                Icons.refresh_rounded,
                color: AppColors.coolGray,
                size: 22.sp,
              ),
            ),
          ],
        ),
        16.ph,
        if (historyController.isLoading && !historyController.hasLoaded)
          Center(
            child: Padding(
              padding: AppInsets.symmetric(vertical: 40),
              child: const CircularProgressIndicator(
                color: AppColors.successGreen,
              ),
            ),
          )
        else if (incidents.isEmpty)
          Container(
            width: double.infinity,
            padding: AppInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.dashboardCardBg,
              borderRadius: 16.circular,
              border: Border.all(
                color: AppColors.primaryWhite.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: AppColors.successGreen,
                    size: 28.sp,
                  ),
                ),
                16.ph,
                Text(
                  'No Incidents Recorded',
                  style: context.titleMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
                8.ph,
                Text(
                  'You have no SOS triggers or expired timer alerts within your 3-day history window.',
                  textAlign: TextAlign.center,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.coolGray,
                  ),
                ),
              ],
            ),
          )
        else
          for (var i = 0; i < incidents.length; i++) ...[
            IncidentCard(
              incident: incidents[i],
              isExpanded: _expandedIndex == i,
              onTap: () {
                setState(() {
                  _expandedIndex = _expandedIndex == i ? null : i;
                });
              },
            ),
            if (i != incidents.length - 1) 12.ph,
          ],
      ],
    );
  }
}
