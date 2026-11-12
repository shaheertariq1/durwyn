import '../../../../core/utils/app_exports.dart';

class RecordPhraseButton extends StatelessWidget {
  const RecordPhraseButton({
    super.key,
    required this.active,
    required this.onTap,
    this.label,
    this.subtitle,
  });

  final bool active;
  final VoidCallback onTap;
  final String? label;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Opacity(
                opacity: active ? 1.0 : 0.5,
                child: Container(
                  width: 128.w,
                  height: 128.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.otpFieldFill,
                    border: Border.all(
                      color: active
                          ? AppColors.primaryRed
                          : AppColors.primaryWhite.withValues(alpha: 0.1),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.permissionsRequiredMicrophoneIcn,
                    width: 48.w,
                    height: 48.h,
                  ),
                ),
              ),
            ),
            12.ph,
            Text(
              label ?? AppStrings.voiceTriggerRecordLabel,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryWhite,
              ),
            ),
            4.ph,
            Text(
              subtitle ?? AppStrings.voiceTriggerRecordSubtitle,
              style: context.bodySmallStyle?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.coolGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
