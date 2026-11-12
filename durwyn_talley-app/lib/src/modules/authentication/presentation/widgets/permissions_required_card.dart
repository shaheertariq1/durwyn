import '../../../../core/utils/app_exports.dart';

class PermissionsRequiredCard extends StatelessWidget {
  const PermissionsRequiredCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.granted,
    required this.onGrant,
  });

  final String title;
  final String subtitle;
  final String icon;
  final bool granted;
  final VoidCallback onGrant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.otpFieldFill,
        borderRadius: 16.circular,
        border: granted
            ? Border.all(color: AppColors.successGreen)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: granted
                  ? AppColors.successGreen
                  : AppColors.choosePlanNeutralChip,
              borderRadius: 16.circular,
            ),
            child: SvgPicture.asset(
              granted ? AppAssetsSvg.permissionsRequiredGrantedCheckIcn : icon,
              width: 24.w,
              height: 24.h,
            ),
          ),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.titleMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
                4.ph,
                Text(
                  subtitle,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
                16.ph,
                if (granted)
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssetsSvg.permissionsRequiredGrantedSmallCheckIcn,
                        width: 16.w,
                        height: 16.h,
                      ),
                      8.pw,
                      Text(
                        AppStrings.permissionsRequiredGrantedLabel,
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ],
                  )
                else
                  PrimaryElevatedButton(
                    onTap: onGrant,
                    text: AppStrings.permissionsRequiredGrantButton,
                    width: 200.w,
                    height: 40.h,
                    radius: 12,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
