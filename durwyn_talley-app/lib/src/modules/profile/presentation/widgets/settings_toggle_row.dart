import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/settings_toggle_item_entity.dart';
import 'settings_item_copy.dart';
import 'settings_toggle_switch.dart';

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.item,
    required this.showDivider,
  });

  final SettingsToggleItemEntity item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  width: 1.085,
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          if (item.icon != null) ...[
            SvgPicture.asset(item.icon!, width: 20.w, height: 20.h),
            12.pw,
          ],
          Expanded(
            child: SettingsItemCopy(title: item.title, subtitle: item.subtitle),
          ),
          12.pw,
          SettingsToggleSwitch(
            label: item.title,
            value: item.value,
            onChanged: item.onChanged,
          ),
        ],
      ),
    );
  }
}
