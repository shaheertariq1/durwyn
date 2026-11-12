import '../../../../core/utils/app_exports.dart';

class CountdownDurationCard extends StatelessWidget {
  const CountdownDurationCard({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          width: 1.085,
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.emergencyPreferencesCountdownTitle,
            style: context.labelMediumStyle?.copyWith(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryWhite,
            ),
          ),
          10.ph,
          Container(
            height: 50.h,
            padding: AppInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: 16.circular,
              border: Border.all(
                width: 1.085,
                color: AppColors.primaryWhite.withValues(alpha: 0.2),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: AppColors.dashboardCardBg,
                borderRadius: 16.circular,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.sp,
                  color: AppColors.primaryWhite,
                ),
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryWhite,
                ),
                onChanged: onChanged,
                items: [
                  for (final option in options)
                    DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
