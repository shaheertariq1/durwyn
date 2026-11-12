import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';
import '../../../contacts/presentation/views/contacts_view.dart';
import '../../../emergency/presentation/views/emergency_view.dart';
import '../../../history/presentation/views/history_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../../domain/entities/dashboard_tab_item_entity.dart';

class DashboardController extends ChangeNotifier with Buffers {
  DashboardController(this._ref) {
    _syncSession();
  }

  final Ref _ref;

  Future<void> _syncSession() async {
    try {
      await _ref.read(authenticationControllerProvider).checkSession();
    } catch (_) {}
  }

  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeView(),
    const EmergencyView(),
    const ContactsView(),
    const HistoryView(),
    const ProfileView(),
  ];

  final List<DashboardTabItemEntity> tabs = [
    const DashboardTabItemEntity(
      icon: AppAssetsSvg.dashboardNavHomeIcn,
      label: AppStrings.navHome,
    ),
    const DashboardTabItemEntity(
      icon: AppAssetsSvg.dashboardNavEmergencyIcn,
      label: AppStrings.navEmergency,
    ),
    const DashboardTabItemEntity(
      icon: AppAssetsSvg.dashboardNavContactsIcn,
      label: AppStrings.navContacts,
    ),
    const DashboardTabItemEntity(
      icon: AppAssetsSvg.dashboardNavHistoryIcn,
      label: AppStrings.navHistory,
    ),
    const DashboardTabItemEntity(
      icon: AppAssetsSvg.dashboardNavProfileIcn,
      label: AppStrings.navProfile,
    ),
  ];

  void onTabTapped(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    notifyListeners();
  }

  bool isSelected(int index) => selectedIndex == index;
}

final dashboardControllerProvider =
    ChangeNotifierProvider.autoDispose<DashboardController>(
      (ref) => DashboardController(ref),
    );
