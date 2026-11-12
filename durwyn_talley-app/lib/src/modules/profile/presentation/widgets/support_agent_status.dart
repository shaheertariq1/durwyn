import '../../../../core/utils/app_exports.dart';

class SupportAgentStatus extends StatelessWidget {
  const SupportAgentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.successGreen,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            AppAssetsSvg.supportChatAgentIcn,
            width: 20.w,
            height: 20.h,
          ),
        ),
        12.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.supportChatAgentName,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryWhite,
                ),
              ),
              Text(
                AppStrings.supportChatOnline,
                style: context.bodySmallStyle?.copyWith(
                  fontSize: 12.sp,
                  height: 16 / 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.successGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
