import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/gps_history_trip_entity.dart';
import 'gps_history_trip_card.dart';

class GpsHistoryListSection extends StatelessWidget {
  const GpsHistoryListSection({super.key});

  static const List<GpsHistoryTripEntity> _trips = [
    GpsHistoryTripEntity(
      date: AppStrings.dashboardGpsHistoryTrip1Date,
      locations: AppStrings.dashboardGpsHistoryTrip1Locations,
      duration: AppStrings.dashboardGpsHistoryTrip1Duration,
      progress: 0.75,
    ),
    GpsHistoryTripEntity(
      date: AppStrings.dashboardGpsHistoryTrip2Date,
      locations: AppStrings.dashboardGpsHistoryTrip2Locations,
      duration: AppStrings.dashboardGpsHistoryTrip2Duration,
      progress: 0.75,
    ),
    GpsHistoryTripEntity(
      date: AppStrings.dashboardGpsHistoryTrip3Date,
      locations: AppStrings.dashboardGpsHistoryTrip3Locations,
      duration: AppStrings.dashboardGpsHistoryTrip3Duration,
      progress: 0.75,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.dashboardGpsHistoryTimelineTitle,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryWhite,
                ),
              ),
              Text(
                AppStrings.dashboardGpsHistoryFilterByDate,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
          16.ph,
          for (final trip in _trips) ...[
            GpsHistoryTripCard(trip: trip),
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
                  AppStrings.dashboardGpsHistoryPremiumTitle,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    height: 28 / 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.successGreen,
                  ),
                ),
                10.ph,
                Text(
                  AppStrings.dashboardGpsHistoryPremiumSubtitle,
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
