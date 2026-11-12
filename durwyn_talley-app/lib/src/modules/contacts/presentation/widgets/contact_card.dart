import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/contact_entity.dart';
import 'permission_tag.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final ContactEntity contact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouterGo.push(contactDetailsView, extra: contact),
      child: Container(
        width: double.infinity,
        padding: AppInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    contact.avatar,
                    width: 56.w,
                    height: 56.h,
                    fit: BoxFit.cover,
                  ),
                ),
                16.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      Text(
                        contact.relationship,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.coolGray,
                        ),
                      ),
                      8.ph,
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssetsSvg.dashboardContactsCallIcn,
                            width: 16.sp,
                            height: 16.sp,
                            colorFilter: const ColorFilter.mode(
                              AppColors.coolGray,
                              BlendMode.srcIn,
                            ),
                          ),
                          8.pw,
                          Text(
                            contact.phone,
                            style: context.bodyMediumStyle?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.coolGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            16.ph,
            Container(
              width: double.infinity,
              padding: AppInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryWhite.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.dashboardContactsPermissionsLabel,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.coolGray,
                    ),
                  ),
                  8.pw,
                  Expanded(
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final permission in contact.permissions)
                          PermissionTag(permission: permission),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
