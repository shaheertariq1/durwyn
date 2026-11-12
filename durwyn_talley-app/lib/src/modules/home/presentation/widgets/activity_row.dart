import '../../../../core/utils/app_exports.dart';

class ActivityRow extends StatelessWidget {
  const ActivityRow({
    super.key,
    required this.title,
    required this.time,
    required this.dotColor,
    required this.showDivider,
  });

  final String title;
  final String time;
  final Color dotColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryWhite,
                  ),
                ),
                Text(
                  time,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.hintGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
