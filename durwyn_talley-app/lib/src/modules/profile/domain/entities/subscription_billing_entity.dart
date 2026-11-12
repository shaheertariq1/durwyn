class SubscriptionBillingEntity {
  const SubscriptionBillingEntity({
    required this.date,
    required this.amount,
    required this.status,
  });

  final String date;
  final String amount;
  final String status;
}
