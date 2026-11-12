import '../../../../core/utils/app_exports.dart';
import '../../../authentication/domain/repositories/auth_repository.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';
import '../../../contacts/presentation/controller/contacts_controller.dart';
import '../../../history/presentation/controller/history_controller.dart';
import '../../domain/entities/help_article_entity.dart';
import '../../domain/entities/help_category_entity.dart';

class ProfileController extends ChangeNotifier with Buffers {
  ProfileController(this._ref)
      : fullNameController = TextEditingController(
          text: _ref.read(authenticationControllerProvider).currentUser?.fullName.isNotEmpty == true
              ? _ref.read(authenticationControllerProvider).currentUser!.fullName
              : AppStrings.dashboardProfileName,
        ),
        phoneNumberController = TextEditingController(
          text: _ref.read(authenticationControllerProvider).currentUser?.phoneNumber.isNotEmpty == true
              ? _ref.read(authenticationControllerProvider).currentUser!.phoneNumber
              : '',
        ),
        emailController = TextEditingController(
          text: _ref.read(authenticationControllerProvider).currentUser?.email.isNotEmpty == true
              ? _ref.read(authenticationControllerProvider).currentUser!.email
              : AppStrings.dashboardProfileEmail,
        ),
        emergencyMessageController = TextEditingController(
          text: (_ref.read(authenticationControllerProvider).currentUser?.emergencyMessage.isNotEmpty == true)
              ? _ref.read(authenticationControllerProvider).currentUser!.emergencyMessage
              : AppStrings.editProfileDefaultEmergencyMessage,
        ),
        changePlanSelected =
            _ref.read(subscriptionControllerProvider).currentPlan {
    supportMessageController.addListener(notifyListeners);
  }

  final Ref _ref;

  final editProfileFormKey = GlobalKey<FormState>();
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final TextEditingController emergencyMessageController;
  bool isSavingProfile = false;

  void pickProfileAvatar(File? file) {
    _ref.read(profileAvatarControllerProvider).setAvatar(file);
  }

  Future<void> saveChanges() async {
    if (!(editProfileFormKey.currentState?.validate() ?? false)) return;
    final authCtrl = _ref.read(authenticationControllerProvider);
    final user = authCtrl.currentUser;
    if (user != null) {
      isSavingProfile = true;
      notifyListeners();
      try {
        final updated = await locator<AuthRepository>().updateProfile(
          uid: user.uid,
          fullName: fullNameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
        );
        authCtrl.currentUser = updated;

        if (emergencyMessageController.text.trim().isNotEmpty) {
          final updatedWithMsg = await locator<AuthRepository>().updateEmergencySettings(
            uid: user.uid,
            emergencyMessage: emergencyMessageController.text.trim(),
          );
          authCtrl.currentUser = updatedWithMsg;
        }

        authCtrl.notifyListeners();
        Prompts.showToast('Profile updated successfully!');
      } catch (e) {
        Prompts.showToast('Failed to save profile: $e', isSuccess: false);
      } finally {
        isSavingProfile = false;
        notifyListeners();
      }
    }
    AppRouterGo.back();
  }

  final changePasswordFormKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void updatePassword() {
    changePasswordFormKey.currentState?.validate();
  }

  bool notifyEmergencyAlerts = true;
  bool notifyTimerReminders = true;
  bool notifyContactActivity = false;
  bool notifyAppUpdates = true;
  bool notifyWeeklySafetyReports = false;
  bool notifySilentHours = false;

  void toggleEmergencyAlerts(bool value) {
    notifyEmergencyAlerts = value;
    notifyListeners();
  }

  void toggleTimerReminders(bool value) {
    notifyTimerReminders = value;
    notifyListeners();
  }

  void toggleContactActivity(bool value) {
    notifyContactActivity = value;
    notifyListeners();
  }

  void toggleAppUpdates(bool value) {
    notifyAppUpdates = value;
    notifyListeners();
  }

  void toggleWeeklySafetyReports(bool value) {
    notifyWeeklySafetyReports = value;
    notifyListeners();
  }

  void toggleSilentHours(bool value) {
    notifySilentHours = value;
    notifyListeners();
  }

  void saveNotificationPreferences() {
    Prompts.showToast(AppStrings.notificationSettingsSaved);
  }

  static const emergencyCountdownOptions = [
    '5 Seconds',
    '10 Second',
    '15 Seconds',
    '30 Seconds',
  ];

  bool autoCallEmergencyServices = false;
  bool shareGpsLocation = true;
  bool sendSmsAlerts = true;
  bool playAlarmSound = true;
  bool notifyAllContacts = false;
  String emergencyCountdownDuration = '10 Second';

  void toggleAutoCallEmergencyServices(bool value) {
    autoCallEmergencyServices = value;
    notifyListeners();
  }

  void toggleShareGpsLocation(bool value) {
    shareGpsLocation = value;
    notifyListeners();
  }

  void toggleSendSmsAlerts(bool value) {
    sendSmsAlerts = value;
    notifyListeners();
  }

  void togglePlayAlarmSound(bool value) {
    playAlarmSound = value;
    notifyListeners();
  }

  void toggleNotifyAllContacts(bool value) {
    notifyAllContacts = value;
    notifyListeners();
  }

  void selectEmergencyCountdownDuration(String? value) {
    if (value == null || value == emergencyCountdownDuration) return;
    emergencyCountdownDuration = value;
    notifyListeners();
  }

  void saveEmergencyPreferences() {
    Prompts.showToast(AppStrings.emergencyPreferencesSaved);
  }

  bool storeLocationHistory = true;
  bool saveAudioRecordings = true;
  bool shareUsageAnalytics = false;
  bool sendCrashReports = true;

  void toggleStoreLocationHistory(bool value) {
    storeLocationHistory = value;
    notifyListeners();
  }

  void toggleSaveAudioRecordings(bool value) {
    saveAudioRecordings = value;
    notifyListeners();
  }

  void toggleShareUsageAnalytics(bool value) {
    shareUsageAnalytics = value;
    notifyListeners();
  }

  void toggleSendCrashReports(bool value) {
    sendCrashReports = value;
    notifyListeners();
  }

  void savePrivacySettings() {
    Prompts.showToast(AppStrings.privacyControlsSaved);
  }

  SubscriptionPlan changePlanSelected;

  void selectChangePlan(SubscriptionPlan plan) {
    if (changePlanSelected == plan) return;
    changePlanSelected = plan;
    notifyListeners();
  }

  Future<void> confirmChangePlan() async {
    final newPlan = changePlanSelected;
    _ref.read(subscriptionControllerProvider).setPlan(newPlan);
    final authCtrl = _ref.read(authenticationControllerProvider);
    if (authCtrl.currentUser != null) {
      try {
        final updated = await locator<AuthRepository>().updatePlan(
          uid: authCtrl.currentUser!.uid,
          subscriptionPlan: newPlan.name,
        );
        authCtrl.currentUser = updated;
      } catch (e) {
        appPrint('Plan update backend error: $e');
      }
    }
    try {
      _ref.read(contactsControllerProvider).fetchContacts(showLoading: false);
      _ref.read(historyControllerProvider).fetchHistory(showLoading: false);
    } catch (_) {}
    Prompts.showToast('Switched to ${newPlan.name.toUpperCase()} Plan!');
  }

  String manageSubscriptionCardNumber = AppStrings.manageSubscriptionCardNumber;
  String manageSubscriptionCardExpiry = AppStrings.manageSubscriptionExpiry;

  final subscriptionSheetCardNumberController = TextEditingController();
  final subscriptionSheetExpiryController = TextEditingController();
  final subscriptionSheetCvvController = TextEditingController();

  void resetSubscriptionSheetFields() {
    subscriptionSheetCardNumberController.clear();
    subscriptionSheetExpiryController.clear();
    subscriptionSheetCvvController.clear();
  }

  bool updateSubscriptionPaymentMethod() {
    final cardDigits = subscriptionSheetCardNumberController.text.replaceAll(
      RegExp(r'\D'),
      '',
    );
    final expiry = subscriptionSheetExpiryController.text.trim();
    final cvv = subscriptionSheetCvvController.text.trim();

    if (cardDigits.length != 16 || expiry.length != 5 || cvv.length < 3) {
      Prompts.showToast(
        AppStrings.manageSubscriptionCompleteCardDetails,
        isSuccess: false,
      );
      return false;
    }

    manageSubscriptionCardNumber = '•••• •••• •••• ${cardDigits.substring(12)}';
    manageSubscriptionCardExpiry = 'Expires $expiry';
    notifyListeners();
    return true;
  }

  final paymentCardNumberController = TextEditingController();
  final paymentExpiryController = TextEditingController();
  final paymentCvvController = TextEditingController();
  final paymentCardNumberFocusNode = FocusNode();
  bool showAddPaymentFields = false;
  String savedPaymentCardNumber = AppStrings.manageSubscriptionCardNumber;
  String savedPaymentCardExpiry = AppStrings.manageSubscriptionExpiry;

  bool get canAddPaymentMethod =>
      paymentCardNumberController.text.trim().isNotEmpty &&
      paymentExpiryController.text.trim().isNotEmpty &&
      paymentCvvController.text.trim().isNotEmpty;

  void onPaymentFieldChanged(String value) => notifyListeners();

  void showPaymentFields() {
    if (showAddPaymentFields) return;
    showAddPaymentFields = true;
    notifyListeners();
  }

  void addPaymentMethod() {
    if (!canAddPaymentMethod) return;

    final digits = paymentCardNumberController.text.replaceAll(
      RegExp(r'\D'),
      '',
    );
    final lastFour =
        digits.length > 4 ? digits.substring(digits.length - 4) : digits;
    final expiry = paymentExpiryController.text.trim();

    savedPaymentCardNumber = '•••• •••• •••• $lastFour';
    savedPaymentCardExpiry = 'Expires $expiry';
    showAddPaymentFields = false;
    paymentCardNumberController.clear();
    paymentExpiryController.clear();
    paymentCvvController.clear();
    notifyListeners();

    Prompts.showToast(AppStrings.hotelPaymentMethodAdded);
  }

  static const List<HelpCategoryEntity> helpCategories = [
    HelpCategoryEntity(
      title: AppStrings.helpCenterGettingStarted,
      icon: AppAssetsSvg.helpCenterGettingStartedIcn,
      articles: [
        HelpArticleEntity(
          question: AppStrings.helpCenterActivateSosQuestion,
          answer: AppStrings.helpCenterActivateSosAnswer,
        ),
        HelpArticleEntity(
          question: AppStrings.helpCenterAddContactsQuestion,
          answer: AppStrings.helpCenterAddContactsAnswer,
        ),
      ],
    ),
    HelpCategoryEntity(
      title: AppStrings.helpCenterVoiceTrigger,
      icon: AppAssetsSvg.helpCenterVoiceTriggerIcn,
      articles: [
        HelpArticleEntity(
          question: AppStrings.helpCenterVoiceTriggerQuestion,
          answer: AppStrings.helpCenterVoiceTriggerAnswer,
        ),
        HelpArticleEntity(
          question: AppStrings.helpCenterVoiceTriggerIssueQuestion,
          answer: AppStrings.helpCenterVoiceTriggerIssueAnswer,
        ),
      ],
    ),
    HelpCategoryEntity(
      title: AppStrings.helpCenterContacts,
      icon: AppAssetsSvg.helpCenterContactsIcn,
      articles: [
        HelpArticleEntity(
          question: AppStrings.helpCenterContactLimitQuestion,
          answer: AppStrings.helpCenterContactLimitAnswer,
        ),
        HelpArticleEntity(
          question: AppStrings.helpCenterContactAlertQuestion,
          answer: AppStrings.helpCenterContactAlertAnswer,
        ),
      ],
    ),
    HelpCategoryEntity(
      title: AppStrings.helpCenterSafetyTimer,
      icon: AppAssetsSvg.helpCenterSafetyTimerIcn,
      articles: [
        HelpArticleEntity(
          question: AppStrings.helpCenterSafetyTimerQuestion,
          answer: AppStrings.helpCenterSafetyTimerAnswer,
        ),
        HelpArticleEntity(
          question: AppStrings.helpCenterExtendTimerQuestion,
          answer: AppStrings.helpCenterExtendTimerAnswer,
        ),
      ],
    ),
  ];

  final helpSearchController = TextEditingController();
  String helpQuery = '';
  String? expandedHelpQuestion = AppStrings.helpCenterActivateSosQuestion;

  List<HelpCategoryEntity> get visibleHelpCategories {
    final query = helpQuery.trim().toLowerCase();
    if (query.isEmpty) return helpCategories;

    return helpCategories
        .map(
          (category) => HelpCategoryEntity(
            title: category.title,
            icon: category.icon,
            articles: category.articles
                .where(
                  (article) =>
                      article.question.toLowerCase().contains(query) ||
                      article.answer.toLowerCase().contains(query),
                )
                .toList(),
          ),
        )
        .where((category) => category.articles.isNotEmpty)
        .toList();
  }

  void onHelpQueryChanged(String value) {
    helpQuery = value;
    notifyListeners();
  }

  void toggleHelpArticle(String question) {
    expandedHelpQuestion = expandedHelpQuestion == question ? null : question;
    notifyListeners();
  }

  final supportMessageController = TextEditingController();

  bool get canSendSupportMessage =>
      supportMessageController.text.trim().isNotEmpty;

  void sendSupportMessage() {
    if (!canSendSupportMessage) return;
    supportMessageController.clear();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    emergencyMessageController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    subscriptionSheetCardNumberController.dispose();
    subscriptionSheetExpiryController.dispose();
    subscriptionSheetCvvController.dispose();
    paymentCardNumberController.dispose();
    paymentExpiryController.dispose();
    paymentCvvController.dispose();
    paymentCardNumberFocusNode.dispose();
    helpSearchController.dispose();
    supportMessageController
      ..removeListener(notifyListeners)
      ..dispose();
    super.dispose();
  }
}

final profileControllerProvider =
    ChangeNotifierProvider.autoDispose<ProfileController>(
  (ref) => ProfileController(ref),
);
