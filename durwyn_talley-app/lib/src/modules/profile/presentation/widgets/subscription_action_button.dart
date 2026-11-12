import '../../../../core/utils/app_exports.dart';

class SubscriptionActionButton extends StatelessWidget {
  const SubscriptionActionButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: AppInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: 16.circular,
        ),
        child: Text(
          label,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            height: 24 / 16,
            fontWeight: FontWeight.w500,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
