import '../../../../core/utils/app_exports.dart';

class SubscriptionCardTitle extends StatelessWidget {
  const SubscriptionCardTitle({
    super.key,
    required this.title,
    this.action,
    this.onActionTap,
  });

  final String title;
  final String? action;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: context.titleLargeStyle?.copyWith(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
        if (action != null)
          GestureDetector(
            onTap: onActionTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: AppInsets.all(2),
              child: Text(
                action!,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.successGreen,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
