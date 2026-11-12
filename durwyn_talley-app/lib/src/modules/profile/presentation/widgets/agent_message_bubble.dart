import '../../../../core/utils/app_exports.dart';

class AgentMessageBubble extends StatelessWidget {
  const AgentMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 318.w,
        padding: AppInsets.only(left: 17, right: 17, top: 13, bottom: 13),
        decoration: BoxDecoration(
          color: AppColors.dashboardCardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          border: Border.all(
            width: 1.085,
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.supportChatGreeting,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryWhite,
              ),
            ),
            Text(
              AppStrings.supportChatGreetingTime,
              style: context.bodySmallStyle?.copyWith(
                fontSize: 12.sp,
                height: 16 / 12,
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
