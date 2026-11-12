import '../../../../core/utils/app_exports.dart';

class SafetyTimerDurationOption extends StatelessWidget {
  const SafetyTimerDurationOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppInsets.symmetric(vertical: 24),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.successGreen.withValues(alpha: 0.1)
              : AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            width: 1.085,
            color: selected
                ? AppColors.successGreen
                : AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 20.sp,
            height: 28 / 20,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
