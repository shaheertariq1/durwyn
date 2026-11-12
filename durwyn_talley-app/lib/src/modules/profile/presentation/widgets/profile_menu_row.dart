import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/profile_menu_item_entity.dart';

class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({super.key, required this.item, required this.showDivider});

  final ProfileMenuItemEntity item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap ?? () {},
      child: Container(
        padding: AppInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.primaryWhite.withValues(alpha: 0.1),
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(item.icon, width: 20.sp, height: 20.sp),
            12.pw,
            Expanded(
              child: Text(
                item.label,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: item.labelColor ?? AppColors.primaryWhite,
                ),
              ),
            ),
            if (item.trailingText != null) ...[
              Text(
                item.trailingText!,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.coolGray,
                ),
              ),
              8.pw,
            ],
            SvgPicture.asset(
              AppAssetsSvg.dashboardProfileChevronRightIcn,
              width: 20.sp,
              height: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
