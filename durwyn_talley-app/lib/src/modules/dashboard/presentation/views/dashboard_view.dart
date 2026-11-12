import '../../../../core/utils/app_exports.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/dashboard_bottom_bar.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dashboardControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: IndexedStack(
        index: controller.selectedIndex,
        children: controller.screens,
      ),
      bottomNavigationBar: DashboardBottomBar(controller: controller),
    );
  }
}
