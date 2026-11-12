import '../../../../core/utils/app_exports.dart';
import '../../../emergency/data/models/incident_model.dart';
import '../../../emergency/domain/repositories/emergency_repository.dart';

class HistoryController extends ChangeNotifier {
  HistoryController() {
    fetchHistory();
  }

  final EmergencyRepository _repository = locator<EmergencyRepository>();

  List<IncidentModel> _incidents = [];
  List<IncidentModel> get incidents => _incidents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasLoaded = false;
  bool get hasLoaded => _hasLoaded;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHistory({bool showLoading = true}) async {
    if (showLoading) {
      _isLoading = true;
      notifyListeners();
    }
    try {
      _incidents = await _repository.getIncidentHistory();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _hasLoaded = true;
      notifyListeners();
    }
  }
}

final historyControllerProvider = ChangeNotifierProvider<HistoryController>(
  (ref) => HistoryController(),
);
