import '../../../../core/utils/app_exports.dart';

class StatusRow extends StatelessWidget {
  const StatusRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20.sp,
              height: 20.sp,
              colorFilter: const ColorFilter.mode(
                AppColors.successGreen,
                BlendMode.srcIn,
              ),
            ),
            12.pw,
            Text(
              label,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryWhite,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: context.bodySmallStyle?.copyWith(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }
}
