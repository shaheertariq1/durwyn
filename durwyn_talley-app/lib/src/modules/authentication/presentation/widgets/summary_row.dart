import '../../../../core/utils/app_exports.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.coolGray,
          ),
        ),
        Text(
          value,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
      ],
    );
  }
}
