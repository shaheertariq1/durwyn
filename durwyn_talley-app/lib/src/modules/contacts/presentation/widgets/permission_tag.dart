import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/contact_permission_entity.dart';

class PermissionTag extends StatelessWidget {
  const PermissionTag({super.key, required this.permission});

  final ContactPermissionEntity permission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.dashboardContactsPermissionTagBg,
        borderRadius: 12.circular,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            permission.icon,
            width: 12.sp,
            height: 12.sp,
            colorFilter: const ColorFilter.mode(
              AppColors.successGreen,
              BlendMode.srcIn,
            ),
          ),
          4.pw,
          Text(
            permission.label,
            style: context.bodySmallStyle?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.successGreen,
            ),
          ),
        ],
      ),
    );
  }
}
