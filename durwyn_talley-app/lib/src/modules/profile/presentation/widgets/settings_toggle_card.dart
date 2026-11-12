import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/settings_toggle_item_entity.dart';
import 'settings_toggle_row.dart';

class SettingsToggleCard extends StatelessWidget {
  const SettingsToggleCard({super.key, required this.items});

  final List<SettingsToggleItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          width: 1.085,
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++)
            SettingsToggleRow(
              item: items[index],
              showDivider: index != items.length - 1,
            ),
        ],
      ),
    );
  }
}
