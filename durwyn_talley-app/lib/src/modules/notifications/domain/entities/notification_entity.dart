import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';

class NotificationEntity {
  const NotificationEntity({
    this.id = '',
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.dateLabel,
    this.isUnread = false,
    this.type = 'system',
  });

  final String id;
  final String icon;
  final Color iconColor;
  final String title;
  final String description;
  final String dateLabel;
  final bool isUnread;
  final String type;

  NotificationEntity copyWith({bool? isUnread}) {
    return NotificationEntity(
      id: id,
      icon: icon,
      iconColor: iconColor,
      title: title,
      description: description,
      dateLabel: dateLabel,
      isUnread: isUnread ?? this.isUnread,
      type: type,
    );
  }

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? 'system';
    String icon = AppAssetsSvg.dashboardNotificationsInfoIcn;
    Color color = AppColors.dashboardQuickActionBlue;

    if (type == 'emergency') {
      icon = AppAssetsSvg.dashboardEmergencyHistoryCheckIcn;
      color = AppColors.eventRed;
    } else if (type == 'timer' || type == 'account') {
      icon = AppAssetsSvg.dashboardEmergencyHistoryCheckIcn;
      color = AppColors.successGreen;
    } else if (type == 'contact') {
      icon = AppAssetsSvg.dashboardNotificationsInfoIcn;
      color = AppColors.dashboardQuickActionBlue;
    }

    return NotificationEntity(
      id: json['id'] as String? ?? '',
      icon: icon,
      iconColor: color,
      title: json['title'] as String? ?? 'Notification',
      description: json['description'] as String? ?? '',
      dateLabel: json['date_label'] as String? ?? 'Recent',
      isUnread: json['is_unread'] as bool? ?? false,
      type: type,
    );
  }
}
