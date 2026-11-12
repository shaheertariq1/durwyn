import '../../../../core/utils/app_exports.dart';
import '../../data/datasources/notifications_remote_data_source.dart';
import '../../domain/entities/notification_entity.dart';
import 'notification_card.dart';

class NotificationsListSection extends StatefulWidget {
  const NotificationsListSection({super.key});

  @override
  State<NotificationsListSection> createState() =>
      _NotificationsListSectionState();
}

class _NotificationsListSectionState extends State<NotificationsListSection> {
  final NotificationsRemoteDataSource _notificationsDataSource =
      locator<NotificationsRemoteDataSource>();

  bool _isLoading = true;
  List<NotificationEntity> _notifications = const [
    NotificationEntity(
      icon: AppAssetsSvg.dashboardEmergencyHistoryCheckIcn,
      iconColor: AppColors.successGreen,
      title: AppStrings.notificationsSafetyCheckTitle,
      description: AppStrings.notificationsSafetyCheckDesc,
      dateLabel: AppStrings.notificationsSafetyCheckDate,
      isUnread: true,
    ),
    NotificationEntity(
      icon: AppAssetsSvg.dashboardNotificationsInfoIcn,
      iconColor: AppColors.dashboardQuickActionBlue,
      title: AppStrings.notificationsNewContactTitle,
      description: AppStrings.notificationsNewContactDesc,
      dateLabel: AppStrings.notificationsNewContactDate,
      isUnread: true,
    ),
    NotificationEntity(
      icon: AppAssetsSvg.dashboardEmergencyHistoryCheckIcn,
      iconColor: AppColors.successGreen,
      title: AppStrings.notificationsSubscriptionTitle,
      description: AppStrings.notificationsSubscriptionDesc,
      dateLabel: AppStrings.notificationsSubscriptionDate,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchLiveNotifications();
  }

  Future<void> _fetchLiveNotifications() async {
    try {
      final liveList = await _notificationsDataSource.getNotifications();
      if (mounted && liveList.isNotEmpty) {
        setState(() {
          _notifications = liveList;
          _isLoading = false;
        });
        return;
      }
    } catch (e) {
      appPrint('Error fetching notifications: $e');
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _markAllRead() async {
    setState(() {
      _notifications = [
        for (final notification in _notifications)
          notification.copyWith(isUnread: false),
      ];
    });

    try {
      await _notificationsDataSource.markAllRead();
    } catch (e) {
      appPrint('Error marking all notifications read: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: AppRouterGo.back,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssetsSvg.dashboardGpsHistoryBackIcn,
                    width: 20.sp,
                    height: 20.sp,
                  ),
                  8.pw,
                  Text(
                    AppStrings.back,
                    style: context.labelMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                AppStrings.notificationsTitle,
                textAlign: TextAlign.center,
                style: context.titleLargeStyle?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryWhite,
                ),
              ),
            ),
            GestureDetector(
              onTap: _markAllRead,
              behavior: HitTestBehavior.opaque,
              child: Text(
                AppStrings.notificationsMarkAllRead,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.successGreen,
                ),
              ),
            ),
          ],
        ),
        24.ph,
        if (_isLoading)
          Center(
            child: Padding(
              padding: AppInsets.all(32),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.successGreen),
              ),
            ),
          )
        else ...[
          for (var i = 0; i < _notifications.length; i++) ...[
            NotificationCard(notification: _notifications[i]),
            if (i != _notifications.length - 1) 10.ph,
          ],
        ],
      ],
    );
  }
}
