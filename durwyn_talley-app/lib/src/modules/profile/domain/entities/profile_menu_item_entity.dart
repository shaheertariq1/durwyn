import 'package:flutter/painting.dart';

class ProfileMenuItemEntity {
  const ProfileMenuItemEntity({
    required this.icon,
    required this.label,
    this.trailingText,
    this.labelColor,
    this.onTap,
  });

  final String icon;
  final String label;
  final String? trailingText;
  final Color? labelColor;
  final VoidCallback? onTap;
}
