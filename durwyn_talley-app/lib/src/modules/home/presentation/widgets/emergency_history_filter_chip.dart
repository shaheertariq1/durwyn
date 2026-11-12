import '../../../../core/utils/app_exports.dart';

class EmergencyHistoryFilterChip extends StatelessWidget {
  const EmergencyHistoryFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.successGreen
              : AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: isSelected
              ? null
              : Border.all(color: AppColors.primaryWhite.withValues(alpha: 0.1)),
        ),
        child: Text(
          label,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 15.sp,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? AppColors.dashboardBackground
                : AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
