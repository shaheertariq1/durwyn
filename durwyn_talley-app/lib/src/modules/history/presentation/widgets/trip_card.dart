import 'dart:math' as math;

import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/history_trip_entity.dart';
import 'timeline_row.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.trip,
    required this.isExpanded,
    required this.onTap,
  });

  final HistoryTripEntity trip;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
              height: 64.h,
              decoration: BoxDecoration(
                border: isExpanded
                    ? Border(
                        bottom: BorderSide(
                          color: AppColors.primaryWhite.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      trip.avatar,
                      width: 48.w,
                      height: 48.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  16.pw,
                  Expanded(
                    child: Text(
                      trip.dateLabel,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: isExpanded ? -math.pi / 2 : math.pi / 2,
                    child: SvgPicture.asset(
                      AppAssetsSvg.dashboardHistoryExpandIcn,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: AppInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  for (var i = 0; i < trip.checkpoints.length; i++)
                    TimelineRow(
                      checkpoint: trip.checkpoints[i],
                      isLast: i == trip.checkpoints.length - 1,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
