import 'dart:math' as math;

import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/history_checkpoint_entity.dart';

class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key, required this.checkpoint, required this.isLast});

  final HistoryCheckpointEntity checkpoint;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  checkpoint.day,
                  textAlign: TextAlign.right,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
                Text(
                  checkpoint.time,
                  textAlign: TextAlign.right,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryWhite.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          16.pw,
          Column(
            children: [
              SvgPicture.asset(
                AppAssetsSvg.dashboardHistoryTimelineNodeIcn,
                width: 20.sp,
                height: 20.sp,
              ),
              if (!isLast)
                Expanded(
                  child: CustomPaint(
                    size: Size(1.w, double.infinity),
                    painter: _DashedLinePainter(
                      color: AppColors.primaryWhite.withValues(alpha: 0.15),
                    ),
                  ),
                ),
            ],
          ),
          16.pw,
          Expanded(
            child: Padding(
              padding: AppInsets.only(bottom: isLast ? 0 : 28),
              child: Text(
                checkpoint.description,
                style: context.bodySmallStyle?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({required this.color});

  final Color color;

  static const _dashHeight = 4.0;
  static const _dashGap = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;
    var y = 0.0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, math.min(y + _dashHeight, size.height)),
        paint,
      );
      y += _dashHeight + _dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldPainter) {
    return oldPainter.color != color;
  }
}
