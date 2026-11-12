import 'package:flutter/foundation.dart';

class SettingsToggleItemEntity {
  const SettingsToggleItemEntity({
    this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String? icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
}
