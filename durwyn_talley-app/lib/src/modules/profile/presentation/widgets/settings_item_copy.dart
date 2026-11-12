import '../../../../core/utils/app_exports.dart';

class SettingsItemCopy extends StatelessWidget {
  const SettingsItemCopy({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bodySmallStyle?.copyWith(
            fontSize: 12.sp,
            height: 16 / 12,
            fontWeight: FontWeight.w400,
            color: AppColors.coolGray,
          ),
        ),
      ],
    );
  }
}
