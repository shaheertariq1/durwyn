import '../../../../core/utils/app_exports.dart';

class ContactInfoTile extends StatelessWidget {
  const ContactInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final String icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.primaryWhite.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 20.sp, height: 20.sp),
          16.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
                Text(
                  value,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
