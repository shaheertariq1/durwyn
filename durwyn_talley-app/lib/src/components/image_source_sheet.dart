import '../core/utils/app_exports.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({
    super.key,
    required this.isDark,
    required this.onPicked,
  });

  final bool isDark;
  final void Function(File?) onPicked;

  static Future<void> show(
    BuildContext context, {
    required bool isDark,
    required void Function(File?) onPicked,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: isDark
          ? AppColors.signInDarkBackground
          : AppColors.signInLightBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => ImageSourceSheet(isDark: isDark, onPicked: onPicked),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppColors.primaryWhite : AppColors.signInLightText;
    final cardColor = isDark ? AppColors.otpFieldFill : AppColors.signInLightSurface;
    final cardBorderColor = isDark
        ? AppColors.signInDarkBorder
        : AppColors.signInLightText.withValues(alpha: 0.1);
    final dividerColor = isDark
        ? AppColors.signInDarkDivider
        : AppColors.signInLightText.withValues(alpha: 0.08);

    return SafeArea(
      child: Padding(
        padding: AppInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: textColor.withValues(alpha: 0.2),
                borderRadius: 2.circular,
              ),
            ),
            20.ph,
            Text(
              AppStrings.selectImage,
              style: context.titleLargeStyle?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            20.ph,
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: 16.circular,
                border: Border.all(color: cardBorderColor),
              ),
              child: Column(
                children: [
                  _SourceTile(
                    iconBackgroundColor: AppColors.successGreen,
                    iconBuilder: (context) => Icon(
                      Icons.camera_alt_outlined,
                      size: 20.sp,
                      color: AppColors.black,
                    ),
                    label: AppStrings.camera,
                    textColor: textColor,
                    onTap: () async {
                      Navigator.of(context).pop();
                      final file = await AppImagePicker.fromCamera();
                      if (file != null) {
                        onPicked(file);
                      }
                    },
                  ),
                  Divider(height: 1, thickness: 1, color: dividerColor),
                  _SourceTile(
                    iconBackgroundColor: AppColors.choosePlanNeutralChip,
                    iconBuilder: (context) => Icon(
                      Icons.photo_library_outlined,
                      size: 20.sp,
                      color: AppColors.coolGray,
                    ),
                    label: AppStrings.chooseFromGallery,
                    textColor: textColor,
                    onTap: () async {
                      Navigator.of(context).pop();
                      final file = await AppImagePicker.fromGallery();
                      if (file != null) {
                        onPicked(file);
                      }
                    },
                  ),
                ],
              ),
            ),
            12.ph,
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: AppInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: 16.circular,
                  border: Border.all(color: cardBorderColor),
                ),
                child: Text(
                  AppStrings.cancel,
                  style: context.labelLargeStyle?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryRed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.iconBackgroundColor,
    required this.iconBuilder,
    required this.label,
    required this.textColor,
    required this.onTap,
  });

  final Color iconBackgroundColor;
  final WidgetBuilder iconBuilder;
  final String label;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: AppInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: 12.circular,
              ),
              child: iconBuilder(context),
            ),
            14.pw,
            Text(
              label,
              style: context.labelLargeStyle?.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
