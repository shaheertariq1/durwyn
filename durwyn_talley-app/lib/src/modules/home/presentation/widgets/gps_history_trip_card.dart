import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/gps_history_trip_entity.dart';

class GpsHistoryTripCard extends StatelessWidget {
  const GpsHistoryTripCard({super.key, required this.trip});

  final GpsHistoryTripEntity trip;

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssetsSvg.dashboardGpsHistoryCalendarIcn,
                          width: 16.sp,
                          height: 16.sp,
                        ),
                        8.pw,
                        Text(
                          trip.date,
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                    8.ph,
                    Row(
                      children: [
                        Text(
                          trip.locations,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                        8.pw,
                        Text(
                          '•',
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                        8.pw,
                        Text(
                          trip.duration,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.pw,
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardGpsHistoryPlayIcn,
                  width: 20.sp,
                  height: 20.sp,
                ),
              ),
            ],
          ),
          16.ph,
          ClipRRect(
            borderRadius: 999.circular,
            child: LinearProgressIndicator(
              value: trip.progress,
              minHeight: 8.h,
              backgroundColor: AppColors.supportChatInputBg,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.successGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
