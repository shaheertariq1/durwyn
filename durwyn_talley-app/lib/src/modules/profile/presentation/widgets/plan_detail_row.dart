import '../../../../core/utils/app_exports.dart';

class PlanDetailRow extends StatelessWidget {
  const PlanDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isPrice = false,
  });

  final String label;
  final String value;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.bodyMediumStyle?.copyWith(
              fontSize: 16.sp,
              height: 24 / 16,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryWhite.withValues(alpha: 0.9),
            ),
          ),
        ),
        Text(
          value,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: (isPrice ? 24 : 16).sp,
            height: isPrice ? 32 / 24 : 24 / 16,
            fontWeight: isPrice ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
      ],
    );
  }
}
