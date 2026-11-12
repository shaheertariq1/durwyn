import 'package:flutter/material.dart';

class SavedRecordingEntity {
  const SavedRecordingEntity({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.duration,
    required this.size,
    required this.type,
  });

  final String icon;
  final Color iconColor;
  final String title;
  final String date;
  final String duration;
  final String size;
  final String type;
}
