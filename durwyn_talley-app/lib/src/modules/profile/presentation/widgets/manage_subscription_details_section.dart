import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/subscription_billing_entity.dart';
import 'billing_history_card.dart';
import 'subscription_features_card.dart';
import 'subscription_payment_method_card.dart';

class ManageSubscriptionDetailsSection extends StatelessWidget {
  const ManageSubscriptionDetailsSection({
    super.key,
    required this.cardNumber,
    required this.expiry,
    required this.onUpdatePaymentMethod,
  });

  final String cardNumber;
  final String expiry;
  final VoidCallback onUpdatePaymentMethod;

  static const List<SubscriptionBillingEntity> _billingHistory = [
    SubscriptionBillingEntity(
      date: AppStrings.manageSubscriptionBillingDateJune,
      amount: AppStrings.manageSubscriptionPriceValue,
      status: AppStrings.manageSubscriptionPaid,
    ),
    SubscriptionBillingEntity(
      date: AppStrings.manageSubscriptionBillingDateMarch,
      amount: AppStrings.manageSubscriptionPriceValue,
      status: AppStrings.manageSubscriptionPaid,
    ),
    SubscriptionBillingEntity(
      date: AppStrings.manageSubscriptionBillingDateDecember,
      amount: AppStrings.manageSubscriptionPriceValue,
      status: AppStrings.manageSubscriptionPaid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SubscriptionFeaturesCard(),
        16.ph,
        SubscriptionPaymentMethodCard(
          cardNumber: cardNumber,
          expiry: expiry,
          onUpdate: onUpdatePaymentMethod,
        ),
        16.ph,
        const BillingHistoryCard(history: _billingHistory),
      ],
    );
  }
}
