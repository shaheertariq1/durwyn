import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/onboarding_slide_data.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthenticationController extends ChangeNotifier with Buffers {
  AuthenticationController(this._ref);

  final Ref _ref;
  final AuthRepository _authRepository = locator<AuthRepository>();

  bool isLoading = false;
  UserEntity? currentUser;
  String? currentToken;
  String? phoneVerificationSessionId;

  final pageController = PageController();
  int currentIndex = 0;

  final signInFormKey = GlobalKey<FormState>();
  final signInEmailController = TextEditingController();
  final signInPasswordController = TextEditingController();
  bool rememberMe = false;

  final forgotPasswordFormKey = GlobalKey<FormState>();
  final forgotPasswordEmailController = TextEditingController();

  final createNewPasswordFormKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final createAccountFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final createAccountEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final securitySetupFormKey = GlobalKey<FormState>();
  final securitySetupPasswordController = TextEditingController();
  final securitySetupConfirmPasswordController = TextEditingController();

  SubscriptionPlan selectedPlan = SubscriptionPlan.free;

  /// True when the payment/subscription-activated screens were entered
  /// from the profile "change plan" flow rather than sign-up onboarding,
  /// so [continueToApp] can return to the dashboard instead of resuming
  /// onboarding.
  bool isChangingPlan = false;

  /// True when the voice trigger / permissions screens were entered from
  /// the profile "manage" menu rather than sign-up onboarding, so their
  /// completion handlers can pop back to the profile instead of resuming
  /// onboarding.
  bool isManagingVoiceTrigger = false;
  bool isManagingPermissions = false;

  PaymentMethod selectedPaymentMethod = PaymentMethod.card;
  final addCardFormKey = GlobalKey<FormState>();
  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardExpiryDateController = TextEditingController();
  final cardCvvController = TextEditingController();
  final cardBillingAddressController = TextEditingController();
  bool saveCardForFuturePayments = false;

  Set<AppPermission> grantedPermissions = {
    AppPermission.location,
    AppPermission.camera,
  };

  final completeProfileFormKey = GlobalKey<FormState>();
  final emergencyMessageController = TextEditingController();

  final emergencyPhraseController = TextEditingController();
  bool isEmergencyPhraseRecorded = false;
  bool isRecordingEmergencyPhrase = false;
  bool isTestingEmergencyPhrase = false;
  Timer? _testPhraseTimer;
  Set<VoiceTriggerType> recordedVoiceTriggers = {};
  VoiceTriggerType? recordingVoiceTrigger;

  bool get isVoiceTriggerSetupComplete =>
      isEmergencyPhraseRecorded &&
      recordedVoiceTriggers.length == VoiceTriggerType.values.length;

  final otpControllers = List.generate(6, (_) => TextEditingController());
  final otpFocusNodes = List.generate(6, (_) => FocusNode());
  static const otpResendDuration = 59;
  int otpResendSeconds = otpResendDuration;
  Timer? _otpResendTimer;
  bool get canResendOtp => otpResendSeconds <= 0;

  static const List<OnboardingSlideData> slides = [
    OnboardingSlideData(
      background: AppAssetsPng.onboardingPersonalSafetyBg,
      title: AppStrings.onboardingSafetyTitle1,
      subtitle: AppStrings.onboardingSafetySubtitle1,
    ),
    OnboardingSlideData(
      background: AppAssetsPng.onboardingLiveEmergencyBg,
      title: AppStrings.onboardingSafetyTitle2,
      subtitle: AppStrings.onboardingSafetySubtitle2,
    ),
    OnboardingSlideData(
      background: AppAssetsPng.onboardingSmartSafetyBg,
      title: AppStrings.onboardingSafetyTitle3,
      subtitle: AppStrings.onboardingSafetySubtitle3,
    ),
  ];

  bool get isLastSlide => currentIndex == slides.length - 1;

  void onPageChanged(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    notifyListeners();
  }

  void skip() => _finishOnboarding();

  void next() {
    if (isLastSlide) {
      _finishOnboarding();
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    AppRouterGo.pushReplacement(signInView);
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  SubscriptionPlan _parsePlan(String plan) {
    switch (plan.toLowerCase()) {
      case 'standard':
        return SubscriptionPlan.standard;
      case 'premium':
        return SubscriptionPlan.premium;
      default:
        return SubscriptionPlan.free;
    }
  }

  Future<void> signIn() async {
    if (!(signInFormKey.currentState?.validate() ?? false)) return;
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.signIn(
        email: signInEmailController.text.trim(),
        password: signInPasswordController.text,
      );
      currentUser = result.user;
      currentToken = result.token;

      final plan = _parsePlan(result.user.subscriptionPlan);
      _ref.read(subscriptionControllerProvider).setPlan(plan);

      Prompts.showSnackBar(
        'Welcome back, ${result.user.fullName}!',
        color: AppColors.successGreen,
      );
      AppRouterGo.pushReplacement(dashboardView);
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      Prompts.showSnackBar(message, color: AppColors.eventRed);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void goToForgotPassword() {
    AppRouterGo.push(forgotPasswordView);
  }

  void goToCreateAccount() {
    AppRouterGo.push(createAccountView);
  }

  void continueCreateAccount() {
    if (!(createAccountFormKey.currentState?.validate() ?? false)) return;
    AppRouterGo.push(securitySetupView);
  }

  Future<void> continueSecuritySetup() async {
    if (!(securitySetupFormKey.currentState?.validate() ?? false)) return;

    if (securitySetupPasswordController.text !=
        securitySetupConfirmPasswordController.text) {
      Prompts.showSnackBar(
        'Passwords do not match',
        color: AppColors.eventRed,
      );
      return;
    }

    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authRepository.signUp(
        email: createAccountEmailController.text.trim(),
        password: securitySetupPasswordController.text,
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        subscriptionPlan: selectedPlan.name,
      );
      currentUser = result.user;
      currentToken = result.token;

      // Send phone verification OTP code
      final phone = phoneNumberController.text.trim();
      if (phone.isNotEmpty) {
        try {
          final phoneRes = await _authRepository.sendPhoneCode(
            phoneNumber: phone,
            token: currentToken,
          );
          phoneVerificationSessionId = phoneRes['session_id'];
        } catch (e) {
          appPrint('Initial sendPhoneCode notice: $e');
        }
      }

      Prompts.showSnackBar(
        'Account created! Verification code sent to $phone.',
        color: AppColors.successGreen,
      );
      _startOtpResendTimer();
      AppRouterGo.push(verifyOtpView);
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      Prompts.showSnackBar(message, color: AppColors.eventRed);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpFocusNodes.length - 1) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  void _startOtpResendTimer() {
    _otpResendTimer?.cancel();
    otpResendSeconds = otpResendDuration;
    _otpResendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpResendSeconds <= 0) {
        timer.cancel();
        return;
      }
      otpResendSeconds--;
      notifyListeners();
      if (otpResendSeconds <= 0) timer.cancel();
    });
  }

  Future<void> resendOtp() async {
    if (!canResendOtp) return;
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final phone = phoneNumberController.text.trim();
      final res = await _authRepository.resendPhoneCode(
        phoneNumber: phone,
        token: currentToken,
      );
      phoneVerificationSessionId = res['session_id'] ?? phoneVerificationSessionId;
      _startOtpResendTimer();
      Prompts.showSnackBar(
        'New verification code sent to $phone',
        color: AppColors.successGreen,
      );
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      Prompts.showSnackBar(message, color: AppColors.eventRed);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyAccount() async {
    final code = otpControllers.map((c) => c.text.trim()).join();
    if (code.length < 6) {
      Prompts.showSnackBar(
        'Please enter all 6 digits of the OTP code',
        color: AppColors.eventRed,
      );
      return;
    }

    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final phone = phoneNumberController.text.trim();
      final result = await _authRepository.verifyPhoneCode(
        phoneNumber: phone,
        code: code,
        sessionId: phoneVerificationSessionId,
        token: currentToken,
      );

      if (result['is_verified'] == true) {
        Prompts.showSnackBar(
          'Phone verified successfully!',
          color: AppColors.successGreen,
        );

        // Pop local notification on device
        try {
          await locator<NotificationService>().showLocalNotification(
            title: 'Phone Verified',
            body: 'Your phone number ($phone) has been securely verified.',
          );
        } catch (_) {}

        AppRouterGo.push(choosePlanView);
      } else {
        Prompts.showSnackBar(
          result['message'] ?? 'Verification failed. Please try again.',
          color: AppColors.eventRed,
        );
      }
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      Prompts.showSnackBar(message, color: AppColors.eventRed);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectPlan(SubscriptionPlan plan) {
    if (selectedPlan == plan) return;
    selectedPlan = plan;
    notifyListeners();
  }

  Future<void> continueWithFreePlan() async {
    selectedPlan = SubscriptionPlan.free;
    _ref.read(subscriptionControllerProvider).setPlan(SubscriptionPlan.free);
    if (currentUser != null) {
      try {
        final updated = await _authRepository.updatePlan(
          uid: currentUser!.uid,
          subscriptionPlan: 'free',
        );
        currentUser = updated;
      } catch (e) {
        appPrint('Plan update error: $e');
      }
    }
    notifyListeners();
    AppRouterGo.pushReplacement(permissionsRequiredView);
  }

  void startChangePlanFlow(SubscriptionPlan plan) {
    isChangingPlan = true;
    selectedPlan = plan;
    selectedPaymentMethod = PaymentMethod.card;
    cardHolderNameController.clear();
    cardNumberController.clear();
    cardExpiryDateController.clear();
    cardCvvController.clear();
    cardBillingAddressController.clear();
    saveCardForFuturePayments = false;
    notifyListeners();
    AppRouterGo.push(paymentMethodView);
  }

  void confirmPlanSelection() {
    if (selectedPlan == SubscriptionPlan.free) {
      continueWithFreePlan();
      return;
    }
    AppRouterGo.push(paymentMethodView);
  }

  void selectPaymentMethod(PaymentMethod method) {
    if (selectedPaymentMethod == method) return;
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void toggleSaveCardForFuturePayments() {
    saveCardForFuturePayments = !saveCardForFuturePayments;
    notifyListeners();
  }

  Future<void> activateSubscription() async {
    if (selectedPaymentMethod == PaymentMethod.card &&
        !(addCardFormKey.currentState?.validate() ?? false)) {
      return;
    }
    _ref.read(subscriptionControllerProvider).setPlan(selectedPlan);
    if (currentUser != null) {
      try {
        final updated = await _authRepository.updatePlan(
          uid: currentUser!.uid,
          subscriptionPlan: selectedPlan.name,
        );
        currentUser = updated;
      } catch (e) {
        appPrint('Plan update error: $e');
      }
    }
    AppRouterGo.push(subscriptionActivatedView);
  }

  void continueToApp() {
    if (isChangingPlan) {
      isChangingPlan = false;
      AppRouterGo.pushRemoveUntil(dashboardView);
      return;
    }
    AppRouterGo.push(permissionsRequiredView);
  }

  Future<void> grantPermission(AppPermission permission) async {
    final Permission perm = switch (permission) {
      AppPermission.location => Permission.locationWhenInUse,
      AppPermission.camera => Permission.camera,
      AppPermission.microphone => Permission.microphone,
      AppPermission.notifications => Permission.notification,
      AppPermission.backgroundActivity => Permission.locationAlways,
    };

    final status = await perm.request();
    if (status.isGranted || status.isLimited) {
      grantedPermissions = {...grantedPermissions, permission};
      notifyListeners();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  void finishPermissionsSetup() {
    if (isManagingPermissions) {
      isManagingPermissions = false;
      AppRouterGo.back();
      return;
    }
    AppRouterGo.pushReplacement(completeProfileView);
  }

  Future<void> startManagePermissions() async {
    isManagingPermissions = true;
    await syncGrantedPermissions();
    AppRouterGo.push(permissionsRequiredView);
  }

  Future<void> syncGrantedPermissions() async {
    final Set<AppPermission> updated = {};
    if (await Permission.locationWhenInUse.isGranted ||
        await Permission.location.isGranted) {
      updated.add(AppPermission.location);
    }
    if (await Permission.camera.isGranted) {
      updated.add(AppPermission.camera);
    }
    if (await Permission.microphone.isGranted) {
      updated.add(AppPermission.microphone);
    }
    if (await Permission.notification.isGranted) {
      updated.add(AppPermission.notifications);
    }
    if (await Permission.locationAlways.isGranted) {
      updated.add(AppPermission.backgroundActivity);
    }
    grantedPermissions = updated;
    notifyListeners();
  }

  void pickProfileAvatar(File? file) {
    _ref.read(profileAvatarControllerProvider).setAvatar(file);
  }

  Future<void> saveProfile() async {
    if (!(completeProfileFormKey.currentState?.validate() ?? false)) return;
    if (currentUser != null && emergencyMessageController.text.trim().isNotEmpty) {
      try {
        final updated = await _authRepository.updateEmergencySettings(
          uid: currentUser!.uid,
          emergencyMessage: emergencyMessageController.text.trim(),
        );
        currentUser = updated;
      } catch (e) {
        appPrint('Emergency message save error: $e');
      }
    }
    AppRouterGo.push(voiceTriggerSetupView);
  }

  void selectEmergencyPhraseExample(String example) {
    emergencyPhraseController.text = example;
    notifyListeners();
  }

  void onEmergencyPhraseChanged(String value) {
    notifyListeners();
  }

  void recordEmergencyPhrase() {
    if (isRecordingEmergencyPhrase) {
      isRecordingEmergencyPhrase = false;
      isEmergencyPhraseRecorded = true;
      notifyListeners();
      return;
    }
    if (emergencyPhraseController.text.trim().isEmpty) {
      Prompts.showSnackBar(
        AppStrings.voiceTriggerPhraseRequiredError,
        color: AppColors.eventRed,
      );
      return;
    }
    isRecordingEmergencyPhrase = true;
    notifyListeners();
  }

  void resetEmergencyPhrase() {
    isEmergencyPhraseRecorded = false;
    isRecordingEmergencyPhrase = false;
    _testPhraseTimer?.cancel();
    isTestingEmergencyPhrase = false;
    emergencyPhraseController.clear();
    recordedVoiceTriggers = {};
    recordingVoiceTrigger = null;
    notifyListeners();
  }

  void testEmergencyPhrase() {
    if (!isEmergencyPhraseRecorded) return;
    _testPhraseTimer?.cancel();
    isTestingEmergencyPhrase = true;
    notifyListeners();
    _testPhraseTimer = Timer(const Duration(seconds: 2), () {
      isTestingEmergencyPhrase = false;
      notifyListeners();
    });
  }

  void toggleVoiceTriggerRecording(VoiceTriggerType type) {
    if (recordingVoiceTrigger == type) {
      recordingVoiceTrigger = null;
      recordedVoiceTriggers = {...recordedVoiceTriggers, type};
      notifyListeners();
      return;
    }
    if (recordedVoiceTriggers.contains(type)) {
      recordedVoiceTriggers = {...recordedVoiceTriggers}..remove(type);
      notifyListeners();
      return;
    }
    recordingVoiceTrigger = type;
    notifyListeners();
  }

  Future<void> completeVoiceTriggerSetup() async {
    if (!isVoiceTriggerSetupComplete) return;
    if (currentUser != null && emergencyPhraseController.text.trim().isNotEmpty) {
      try {
        final updated = await _authRepository.updateEmergencySettings(
          uid: currentUser!.uid,
          emergencyPhrase: emergencyPhraseController.text.trim(),
        );
        currentUser = updated;
      } catch (e) {
        appPrint('Emergency phrase save error: $e');
      }
    }
    if (isManagingVoiceTrigger) {
      isManagingVoiceTrigger = false;
      AppRouterGo.back();
      return;
    }
    AppRouterGo.pushReplacement(dashboardView);
  }

  void skipVoiceTriggerSetup() {
    if (isManagingVoiceTrigger) {
      isManagingVoiceTrigger = false;
      AppRouterGo.back();
      return;
    }
    AppRouterGo.pushReplacement(dashboardView);
  }

  void startManageVoiceTrigger() {
    isManagingVoiceTrigger = true;
    AppRouterGo.push(voiceTriggerSetupView);
  }

  void sendResetLink() {
    if (!(forgotPasswordFormKey.currentState?.validate() ?? false)) return;
    AppRouterGo.push(createNewPasswordView);
  }

  void resetPassword() {
    if (!(createNewPasswordFormKey.currentState?.validate() ?? false)) return;
    AppRouterGo.pushReplacement(signInView);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    currentUser = null;
    currentToken = null;
    AppRouterGo.pushReplacement(signInView);
  }

  Future<bool> checkSession() async {
    try {
      final token = await _authRepository.getCachedToken();
      if (token == null || token.isEmpty) return false;
      currentToken = token;

      try {
        final freshUser = await _authRepository.getMe();
        currentUser = freshUser;
        final plan = _parsePlan(freshUser.subscriptionPlan);
        _ref.read(subscriptionControllerProvider).setPlan(plan);
        notifyListeners();
        return true;
      } catch (_) {
        final cached = await _authRepository.getCachedUser();
        if (cached != null) {
          currentUser = cached;
          final plan = _parsePlan(cached.subscriptionPlan);
          _ref.read(subscriptionControllerProvider).setPlan(plan);
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    signInEmailController.dispose();
    signInPasswordController.dispose();
    forgotPasswordEmailController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    fullNameController.dispose();
    createAccountEmailController.dispose();
    phoneNumberController.dispose();
    securitySetupPasswordController.dispose();
    securitySetupConfirmPasswordController.dispose();
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    cardExpiryDateController.dispose();
    cardCvvController.dispose();
    cardBillingAddressController.dispose();
    emergencyMessageController.dispose();
    emergencyPhraseController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    _otpResendTimer?.cancel();
    _testPhraseTimer?.cancel();
    super.dispose();
  }
}

final authenticationControllerProvider =
    ChangeNotifierProvider<AuthenticationController>(
  (ref) => AuthenticationController(ref),
);
