import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/saved_recording_entity.dart';

class SavedRecordingCard extends StatelessWidget {
  const SavedRecordingCard({super.key, required this.recording});

  final SavedRecordingEntity recording;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.primaryWhite.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: recording.iconColor,
                  borderRadius: 16.circular,
                ),
                child: SvgPicture.asset(
                  recording.icon,
                  width: 28.sp,
                  height: 28.sp,
                ),
              ),
              16.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recording.title,
                      style: context.labelMediumStyle?.copyWith(
                        fontSize: 18.sp,
                        height: 28 / 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    4.ph,
                    Text(
                      recording.date,
                      style: context.bodySmallStyle?.copyWith(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.coolGray,
                      ),
                    ),
                    4.ph,
                    Row(
                      children: [
                        Text(
                          recording.duration,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                        8.pw,
                        Text(
                          '•',
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                        8.pw,
                        Text(
                          recording.size,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.coolGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          Container(
            width: double.infinity,
            padding: AppInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      borderRadius: 12.circular,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssetsSvg.dashboardSavedRecordingsPlayIcn,
                          width: 16.sp,
                          height: 16.sp,
                        ),
                        8.pw,
                        Text(
                          AppStrings.dashboardSavedRecordingsPlayLabel,
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dashboardBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                8.pw,
                _SavedRecordingIconButton(
                  icon: AppAssetsSvg.dashboardSavedRecordingsDownloadIcn,
                  backgroundColor: AppColors.supportChatInputBg,
                ),
                8.pw,
                _SavedRecordingIconButton(
                  icon: AppAssetsSvg.dashboardSavedRecordingsShareIcn,
                  backgroundColor: AppColors.supportChatInputBg,
                ),
                8.pw,
                _SavedRecordingIconButton(
                  icon: AppAssetsSvg.dashboardSavedRecordingsDeleteIcn,
                  backgroundColor: AppColors.dashboardSosRed.withValues(
                    alpha: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedRecordingIconButton extends StatelessWidget {
  const _SavedRecordingIconButton({
    required this.icon,
    required this.backgroundColor,
  });

  final String icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: 12.circular,
      ),
      child: SvgPicture.asset(icon, width: 16.sp, height: 16.sp),
    );
  }
}
