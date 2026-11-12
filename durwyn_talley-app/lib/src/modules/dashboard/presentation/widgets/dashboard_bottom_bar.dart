import '../../../../core/utils/app_exports.dart';
import '../controller/dashboard_controller.dart';

class DashboardBottomBar extends StatelessWidget {
  const DashboardBottomBar({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.dashboardCardBg),
      child: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox(
          height: 80.h,
          child: Row(
            children: List.generate(controller.tabs.length, (i) {
              final selected = controller.isSelected(i);
              final tab = controller.tabs[i];
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.onTabTapped(i),
                  child: Padding(
                    padding: AppInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          tab.icon,
                          width: 24.sp,
                          height: 24.sp,
                          colorFilter: ColorFilter.mode(
                            selected
                                ? AppColors.successGreen
                                : AppColors.travellerNavInactive,
                            BlendMode.srcIn,
                          ),
                        ),
                        6.ph,
                        Text(
                          tab.label,
                          style: context.labelSmallStyle?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: selected
                                ? AppColors.successGreen
                                : AppColors.travellerNavInactive,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
