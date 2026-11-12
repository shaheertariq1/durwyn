import '../../../../core/utils/app_exports.dart';

class EmergencyPermissionCheckboxRow extends StatelessWidget {
  const EmergencyPermissionCheckboxRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: double.infinity,
        padding: AppInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: 16.circular,
          border: Border.all(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: context.labelMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryWhite,
              ),
            ),
            Container(
              width: 20.w,
              height: 20.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: value ? AppColors.successGreen : AppColors.transparent,
                borderRadius: 5.circular,
                border: Border.all(
                  color: value
                      ? AppColors.successGreen
                      : AppColors.primaryWhite,
                ),
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      size: 14.sp,
                      color: AppColors.dashboardBackground,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
