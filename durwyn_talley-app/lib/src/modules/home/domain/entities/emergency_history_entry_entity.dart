import 'package:flutter/material.dart';

class EmergencyHistoryEntryEntity {
  const EmergencyHistoryEntryEntity({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.duration,
    required this.contactsNotified,
  });

  final String icon;
  final Color iconColor;
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final String duration;
  final String contactsNotified;
}
