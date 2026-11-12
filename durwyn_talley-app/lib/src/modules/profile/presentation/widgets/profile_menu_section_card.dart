import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/profile_menu_section_entity.dart';
import 'profile_menu_row.dart';

class ProfileMenuSectionCard extends StatelessWidget {
  const ProfileMenuSectionCard({super.key, required this.section});

  final ProfileMenuSectionEntity section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.coolGray,
            letterSpacing: 0.7,
          ),
        ),
        10.ph,
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.dashboardCardBg,
            borderRadius: 16.circular,
            border: Border.all(
              color: AppColors.primaryWhite.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              for (var i = 0; i < section.items.length; i++)
                ProfileMenuRow(
                  item: section.items[i],
                  showDivider: i != section.items.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
