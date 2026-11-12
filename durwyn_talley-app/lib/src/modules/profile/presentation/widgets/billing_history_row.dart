import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/subscription_billing_entity.dart';

class BillingHistoryRow extends StatelessWidget {
  const BillingHistoryRow({super.key, required this.item});

  final SubscriptionBillingEntity item;

  @override
  Widget build(BuildContext context) {
    final regularStyle = context.bodyMediumStyle?.copyWith(
      fontSize: 16.sp,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryWhite,
    );

    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          size: 16.sp,
          color: AppColors.coolGray,
        ),
        12.pw,
        Expanded(
          child: Text(item.date, maxLines: 1, style: regularStyle),
        ),
        Text(
          item.amount,
          style: regularStyle?.copyWith(fontWeight: FontWeight.w500),
        ),
        12.pw,
        Text(
          item.status,
          style: context.bodySmallStyle?.copyWith(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }
}
