import '../../../../core/utils/app_exports.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dashboardCardBg,
        borderRadius: 16.circular,
        border: Border.all(
          color: AppColors.primaryWhite.withValues(alpha: 0.1),
        ),
      ),
      child: child,
    );
  }
}
