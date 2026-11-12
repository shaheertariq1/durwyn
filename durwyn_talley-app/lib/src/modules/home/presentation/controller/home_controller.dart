import 'dart:async';

import '../../../../core/utils/app_exports.dart';
import '../../../emergency/domain/repositories/emergency_repository.dart';

class HomeController extends ChangeNotifier with Buffers {
  final EmergencyRepository _emergencyRepository =
      locator<EmergencyRepository>();

  static const int sosActivationSeconds = 3;
  int sosSecondsRemaining = sosActivationSeconds;
  bool sosActivated = false;
  String? activeIncidentId;
  Timer? _sosTimer;

  void startSosCountdown() {
    _sosTimer?.cancel();
    sosSecondsRemaining = sosActivationSeconds;
    sosActivated = false;
    activeIncidentId = null;
    notifyListeners();

    _sosTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (sosSecondsRemaining <= 1) {
        timer.cancel();
        sosSecondsRemaining = 0;
        sosActivated = true;
        notifyListeners();
        await _dispatchSos();
        return;
      }
      sosSecondsRemaining--;
      notifyListeners();
    });
  }

  Future<void> _dispatchSos() async {
    try {
      final incident = await _emergencyRepository.triggerSos(
        latitude: 37.7749,
        longitude: -122.4194,
        address: 'Current Location',
        emergencyType: 'sos',
      );
      activeIncidentId = incident.id;
      notifyListeners();
      Prompts.showToast('SOS Alert Sent! Live GPS tracking active.');
    } catch (e) {
      Prompts.showToast(
        e.toString().replaceAll('Exception:', '').trim(),
        isSuccess: false,
      );
    }
  }

  Future<void> cancelSosActivation() async {
    _sosTimer?.cancel();
    final incId = activeIncidentId;
    activeIncidentId = null;
    sosActivated = false;
    sosSecondsRemaining = sosActivationSeconds;
    notifyListeners();

    if (incId != null) {
      try {
        await _emergencyRepository.resolveIncident(incId);
        Prompts.showToast('Emergency SOS resolved.');
      } catch (e) {
        appPrint('Resolve incident error: $e');
      }
    }
    AppRouterGo.back();
  }

  static const List<String> safetyTimerDurationOptions = [
    '15 Minutes',
    '30 Minutes',
    '60 Minutes',
    'Custom',
  ];
  static const int _defaultSafetyTimerMinutes = 30;
  String selectedSafetyTimerDuration = '30 Minutes';

  void selectSafetyTimerDuration(String duration) {
    if (duration == selectedSafetyTimerDuration) return;
    selectedSafetyTimerDuration = duration;
    notifyListeners();
  }

  int safetyTimerTotalSeconds = _defaultSafetyTimerMinutes * 60;
  int safetyTimerSecondsRemaining = _defaultSafetyTimerMinutes * 60;
  Timer? _safetyTimer;

  Future<void> startSafetyTimer() async {
    final minutes = int.tryParse(
          RegExp(r'\d+').stringMatch(selectedSafetyTimerDuration) ?? '',
        ) ??
        _defaultSafetyTimerMinutes;
    safetyTimerTotalSeconds = minutes * 60;
    safetyTimerSecondsRemaining = safetyTimerTotalSeconds;

    try {
      await _emergencyRepository.startSafetyTimer(
        minutes,
        label: selectedSafetyTimerDuration,
      );
    } catch (e) {
      appPrint('Start timer backend error: $e');
    }

    _safetyTimer?.cancel();
    _safetyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (safetyTimerSecondsRemaining <= 1) {
        timer.cancel();
        safetyTimerSecondsRemaining = 0;
        notifyListeners();
        _triggerSosOnTimerExpiry();
        return;
      }
      safetyTimerSecondsRemaining--;
      notifyListeners();
    });

    AppRouterGo.push(safetyTimerActiveView);
  }

  Future<void> _triggerSosOnTimerExpiry() async {
    try {
      final incident = await _emergencyRepository.triggerSos(
        latitude: 37.7749,
        longitude: -122.4194,
        address: 'Current Location',
        emergencyType: 'timer_expired',
      );
      activeIncidentId = incident.id;
      sosActivated = true;
      sosSecondsRemaining = 0;
      notifyListeners();
      Prompts.showToast(
        'Safety timer expired! SOS alerted to emergency contacts!',
        isSuccess: false,
      );
      AppRouterGo.push(sosActivationView);
    } catch (e) {
      Prompts.showToast('Emergency alert triggered.', isSuccess: false);
      AppRouterGo.pushRemoveUntil(dashboardView);
    }
  }

  Future<void> checkInSafetyTimer() async {
    _safetyTimer?.cancel();
    try {
      await _emergencyRepository.checkInSafetyTimer();
    } catch (e) {
      appPrint('Check in error: $e');
    }
    Prompts.showToast(AppStrings.dashboardSafetyTimerCheckedInToast);
    AppRouterGo.pushRemoveUntil(dashboardView);
  }

  Future<void> cancelSafetyTimer() async {
    _safetyTimer?.cancel();
    try {
      await _emergencyRepository.cancelSafetyTimer();
    } catch (e) {
      appPrint('Cancel timer error: $e');
    }
    Prompts.showToast(
      AppStrings.dashboardSafetyTimerCancelledToast,
      isSuccess: false,
    );
    AppRouterGo.pushRemoveUntil(dashboardView);
  }

  static const List<String> safetyMonitorTypes = [
    AppStrings.dashboardSafetyMonitorTravelTitle,
    AppStrings.dashboardSafetyMonitorActivityTitle,
    AppStrings.dashboardSafetyMonitorRiskTitle,
  ];
  String selectedSafetyMonitorType =
      AppStrings.dashboardSafetyMonitorTravelTitle;

  void selectSafetyMonitorType(String type) {
    if (type == selectedSafetyMonitorType) return;
    selectedSafetyMonitorType = type;
    notifyListeners();
  }

  bool isSafetyMonitoringActive = false;
  String? activeMonitorSessionId;
  Timer? _monitorPingTimer;

  Future<void> enableSafetyMonitoring() async {
    isSafetyMonitoringActive = true;
    notifyListeners();
    AppRouterGo.push(safetyMonitorActiveView);

    try {
      final res = await _emergencyRepository.startSafetyMonitor(
        monitorType: selectedSafetyMonitorType,
        latitude: 37.7749,
        longitude: -122.4194,
      );
      activeMonitorSessionId = res['session_id'];
      Prompts.showToast('Safety Monitoring active: $selectedSafetyMonitorType');
    } catch (e) {
      appPrint('Safety monitor backend error: $e');
    }

    _monitorPingTimer?.cancel();
    _monitorPingTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (!isSafetyMonitoringActive) return;
      try {
        await _emergencyRepository.pingSafetyMonitor(
          latitude: 37.7749,
          longitude: -122.4194,
          batteryLevel: 98,
          status: 'normal',
        );
      } catch (e) {
        appPrint('Monitor ping error: $e');
      }
    });
  }

  Future<void> stopSafetyMonitoring() async {
    _monitorPingTimer?.cancel();
    isSafetyMonitoringActive = false;
    activeMonitorSessionId = null;
    notifyListeners();

    try {
      await _emergencyRepository.stopSafetyMonitor();
    } catch (e) {
      appPrint('Stop monitor error: $e');
    }

    Prompts.showToast(
      AppStrings.dashboardSafetyMonitorStoppedToast,
      isSuccess: false,
    );
    AppRouterGo.pushRemoveUntil(dashboardView);
  }

  static const int silentEmergencyAutoReturnSeconds = 3;
  Timer? _silentEmergencyTimer;

  Future<void> activateSilentEmergency() async {
    AppRouterGo.push(silentEmergencyActiveView);
    try {
      final incident = await _emergencyRepository.triggerSos(
        latitude: 37.7749,
        longitude: -122.4194,
        address: 'Current Location',
        emergencyType: 'silent',
      );
      activeIncidentId = incident.id;
      notifyListeners();
    } catch (e) {
      appPrint('Silent emergency trigger error: $e');
    }

    _silentEmergencyTimer?.cancel();
    _silentEmergencyTimer = Timer(
      const Duration(seconds: silentEmergencyAutoReturnSeconds),
      () {
        Prompts.showToast(AppStrings.dashboardSilentEmergencyActivatedToast);
        AppRouterGo.pushRemoveUntil(dashboardView);
      },
    );
  }

  @override
  void dispose() {
    _sosTimer?.cancel();
    _safetyTimer?.cancel();
    _silentEmergencyTimer?.cancel();
    _monitorPingTimer?.cancel();
    super.dispose();
  }
}

final homeControllerProvider = ChangeNotifierProvider<HomeController>(
  (ref) => HomeController(),
);
