// App Enums


enum SubscriptionPlan { free, standard, premium }

extension SubscriptionPlanLimits on SubscriptionPlan {
  /// Maximum number of emergency contacts allowed on this plan.
  int get maxContacts => switch (this) {
    SubscriptionPlan.free => 1,
    SubscriptionPlan.standard => 4,
    SubscriptionPlan.premium => 7,
  };

  /// Retention window for incident history evidence in days.
  int get evidenceRetentionDays => switch (this) {
    SubscriptionPlan.free => 3,
    SubscriptionPlan.standard => 14,
    SubscriptionPlan.premium => 30,
  };
}

enum PaymentMethod { card, applePay, googlePay }

enum AppPermission { location, camera, microphone, notifications, backgroundActivity }

enum VoiceTriggerType { safetyMonitor, silentEmergency, silentTimer }
