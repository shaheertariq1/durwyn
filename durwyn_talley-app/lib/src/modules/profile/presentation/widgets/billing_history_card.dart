import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/subscription_billing_entity.dart';
import 'billing_history_row.dart';
import 'subscription_card.dart';
import 'subscription_card_title.dart';

class BillingHistoryCard extends StatelessWidget {
  const BillingHistoryCard({super.key, required this.history});

  final List<SubscriptionBillingEntity> history;

  @override
  Widget build(BuildContext context) {
    return SubscriptionCard(
      child: Column(
        children: [
          SubscriptionCardTitle(
            title: AppStrings.manageSubscriptionBillingHistory,
            action: AppStrings.manageSubscriptionViewAll,
            onActionTap: () {},
          ),
          16.ph,
          for (var index = 0; index < history.length; index++) ...[
            BillingHistoryRow(item: history[index]),
            if (index != history.length - 1) 8.ph,
          ],
        ],
      ),
    );
  }
}
