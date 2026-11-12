import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: notification.isUnread
            ? AppColors.successGreen.withValues(alpha: 0.05)
            : AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          color: notification.isUnread
              ? AppColors.successGreen.withValues(alpha: 0.2)
              : AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: notification.iconColor,
              borderRadius: 16.circular,
            ),
            child: SvgPicture.asset(
              notification.icon,
              width: 24.sp,
              height: 24.sp,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 18.sp,
                          height: 27 / 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                    if (notification.isUnread)
                      Container(
                        width: 8.w,
                        height: 8.h,
                        margin: EdgeInsets.only(top: 4.h),
                        decoration: const BoxDecoration(
                          color: AppColors.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                4.ph,
                Text(
                  notification.description,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.coolGray,
                  ),
                ),
                8.ph,
                Text(
                  notification.dateLabel,
                  style: context.labelSmallStyle?.copyWith(
                    fontSize: 12.sp,
                    height: 16 / 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.coolGray,
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
