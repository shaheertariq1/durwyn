// ignore_for_file: strict_top_level_inference

// This is also known as declerative routing
import '../../utils/app_exports.dart';
import '../../../modules/authentication/presentation/views/onboarding_view.dart';
import '../../../modules/authentication/presentation/views/sign_in_view.dart';
import '../../../modules/authentication/presentation/views/forgot_password_view.dart';
import '../../../modules/authentication/presentation/views/create_new_password_view.dart';
import '../../../modules/authentication/presentation/views/create_account_view.dart';
import '../../../modules/authentication/presentation/views/security_setup_view.dart';
import '../../../modules/authentication/presentation/views/verify_otp_view.dart';
import '../../../modules/authentication/presentation/views/choose_plan_view.dart';
import '../../../modules/authentication/presentation/views/payment_method_view.dart';
import '../../../modules/authentication/presentation/views/subscription_activated_view.dart';
import '../../../modules/authentication/presentation/views/permissions_required_view.dart';
import '../../../modules/authentication/presentation/views/complete_profile_view.dart';
import '../../../modules/authentication/presentation/views/voice_trigger_setup_view.dart';
import '../../../modules/dashboard/presentation/views/dashboard_view.dart';
import '../../../modules/home/presentation/views/sos_activation_view.dart';
import '../../../modules/home/presentation/views/safety_timer_view.dart';
import '../../../modules/home/presentation/views/safety_timer_active_view.dart';
import '../../../modules/home/presentation/views/safety_monitor_active_view.dart';
import '../../../modules/home/presentation/views/safety_monitor_view.dart';
import '../../../modules/home/presentation/views/silent_emergency_view.dart';
import '../../../modules/home/presentation/views/silent_emergency_active_view.dart';
import '../../../modules/contacts/presentation/views/add_emergency_contact_view.dart';
import '../../../modules/contacts/presentation/views/contact_details_view.dart';
import '../../../modules/contacts/domain/entities/contact_entity.dart';
import '../../../modules/home/presentation/views/emergency_history_view.dart';
import '../../../modules/home/presentation/views/gps_history_view.dart';
import '../../../modules/home/presentation/views/saved_recordings_view.dart';
import '../../../modules/notifications/presentation/views/notifications_view.dart';
import '../../../modules/profile/presentation/views/edit_profile_view.dart';
import '../../../modules/profile/presentation/views/change_password_view.dart';
import '../../../modules/profile/presentation/views/manage_subscription_view.dart';
import '../../../modules/profile/presentation/views/change_plan_view.dart';
import '../../../modules/profile/presentation/views/profile_payment_method_view.dart';
import '../../../modules/profile/presentation/views/emergency_preferences_view.dart';
import '../../../modules/profile/presentation/views/notification_settings_view.dart';
import '../../../modules/profile/presentation/views/privacy_controls_view.dart';
import '../../../modules/profile/presentation/views/help_center_view.dart';
import '../../../modules/profile/presentation/views/support_chat_view.dart';

class AppRouterGo {
  static BuildContext get context =>
      appRouter.routerDelegate.navigatorKey.currentContext!;

  static String initialRoute = onboardingView;

  static final appRouter = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: onboardingView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
        ),
      ),
      GoRoute(
        path: signInView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SignInView(),
        ),
      ),
      GoRoute(
        path: forgotPasswordView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: createNewPasswordView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CreateNewPasswordView(),
        ),
      ),
      GoRoute(
        path: createAccountView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CreateAccountView(),
        ),
      ),
      GoRoute(
        path: securitySetupView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SecuritySetupView(),
        ),
      ),
      GoRoute(
        path: verifyOtpView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const VerifyOtpView(),
        ),
      ),
      GoRoute(
        path: choosePlanView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ChoosePlanView(),
        ),
      ),
      GoRoute(
        path: paymentMethodView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const PaymentMethodView(),
        ),
      ),
      GoRoute(
        path: subscriptionActivatedView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SubscriptionActivatedView(),
        ),
      ),
      GoRoute(
        path: permissionsRequiredView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const PermissionsRequiredView(),
        ),
      ),
      GoRoute(
        path: completeProfileView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CompleteProfileView(),
        ),
      ),
      GoRoute(
        path: voiceTriggerSetupView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const VoiceTriggerSetupView(),
        ),
      ),
      GoRoute(
        path: dashboardView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const DashboardView(),
        ),
      ),
      GoRoute(
        path: editProfileView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const EditProfileView(),
        ),
      ),
      GoRoute(
        path: changePasswordView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ChangePasswordView(),
        ),
      ),
      GoRoute(
        path: manageSubscriptionView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ManageSubscriptionView(),
        ),
      ),
      GoRoute(
        path: changePlanView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ChangePlanView(),
        ),
      ),
      GoRoute(
        path: profilePaymentMethodView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const ProfilePaymentMethodView(),
        ),
      ),
      GoRoute(
        path: emergencyPreferencesView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const EmergencyPreferencesView(),
        ),
      ),
      GoRoute(
        path: notificationSettingsView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const NotificationSettingsView(),
        ),
      ),
      GoRoute(
        path: privacyControlsView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const PrivacyControlsView(),
        ),
      ),
      GoRoute(
        path: helpCenterView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const HelpCenterView(),
        ),
      ),
      GoRoute(
        path: supportChatView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SupportChatView(),
        ),
      ),
      GoRoute(
        path: sosActivationView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SosActivationView(),
        ),
      ),
      GoRoute(
        path: safetyTimerView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SafetyTimerView(),
        ),
      ),
      GoRoute(
        path: safetyTimerActiveView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SafetyTimerActiveView(),
        ),
      ),
      GoRoute(
        path: safetyMonitorView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SafetyMonitorView(),
        ),
      ),
      GoRoute(
        path: safetyMonitorActiveView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SafetyMonitorActiveView(),
        ),
      ),
      GoRoute(
        path: silentEmergencyView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SilentEmergencyView(),
        ),
      ),
      GoRoute(
        path: silentEmergencyActiveView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SilentEmergencyActiveView(),
        ),
      ),
      GoRoute(
        path: addEmergencyContactView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AddEmergencyContactView(),
        ),
      ),
      GoRoute(
        path: contactDetailsView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: ContactDetailsView(contact: state.extra! as ContactEntity),
        ),
      ),
      GoRoute(
        path: emergencyHistoryView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const EmergencyHistoryView(),
        ),
      ),
      GoRoute(
        path: gpsHistoryView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const GpsHistoryView(),
        ),
      ),
      GoRoute(
        path: savedRecordingsView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SavedRecordingsView(),
        ),
      ),
      GoRoute(
        path: notificationsView,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const NotificationsView(),
        ),
      ),
    ],
  );

  static void back() {
    if (context.canPop()) {
      context.pop();
    }
  }

  static void push(location, {Object? extra, Function(dynamic)? onThen}) {
    context.push(location, extra: extra).then((value) {
      onThen?.call(value);
    });
  }

  static pushRemoveUntil(location) {
    context.go(location);
  }

  static pushReplacement(location, {Object? extra}) {
    context.replace(location, extra: extra);
  }
}
