import '../core/utils/app_exports.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
    required this.isDark,
    required this.iconColor,
  });

  final bool isDark;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: AppRouterGo.back,
      child: Container(
        width: 36.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.travellerBorder
              : AppColors.signInLightSurface,
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark
                ? AppColors.travellerBorder
                : AppColors.signInLightText.withValues(alpha: 0.1),
          ),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          size: 20.sp,
          color: iconColor,
        ),
      ),
    );
  }
}
