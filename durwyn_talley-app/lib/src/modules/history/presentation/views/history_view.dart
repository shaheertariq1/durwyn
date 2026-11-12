import '../../../../components/dashboard_header_section.dart';
import '../../../../core/utils/app_exports.dart';
import '../widgets/history_list_section.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.dashboardBackground,
      child: Column(
        children: [
          const DashboardHeaderSection(showProtectionBanner: false),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 24, vertical: 24),
                child: const HistoryListSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
