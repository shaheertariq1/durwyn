import 'package:durwyn_talley/src/core/utils/app_exports.dart';

class TravellerFilterChip extends StatelessWidget {
  const TravellerFilterChip({
    super.key,
    required this.isDark,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final bool isDark;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final unselectedTextColor =
        isDark ? AppColors.travellerMutedText : AppColors.signInLightText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryRed
              : (isDark ? AppColors.travellerCardBg : AppColors.primaryWhite),
          borderRadius: 999.circular,
          border: selected
              ? null
              : Border.all(
                  color: isDark
                      ? AppColors.travellerBorder
                      : AppColors.signInLightText.withValues(alpha: 0.1),
                ),
        ),
        child: Text(
          label,
          style: context.labelLargeStyle?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.primaryWhite : unselectedTextColor,
          ),
        ),
      ),
    );
  }
}
