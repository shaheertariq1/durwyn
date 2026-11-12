import '../core/utils/app_exports.dart';
import '../modules/authentication/presentation/controller/authentication_controller.dart';
import '../modules/dashboard/presentation/controller/dashboard_controller.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = ref.watch(authenticationControllerProvider);
    final user = authCtrl.currentUser;
    final fullName = user?.fullName.trim() ?? '';
    final firstName = fullName.isNotEmpty ? fullName.split(' ').first : '';
    final greeting = firstName.isNotEmpty
        ? 'Hi, $firstName'
        : AppStrings.dashboardHomeGreeting;

    return Row(
      children: [
        GestureDetector(
          onTap: () => ref.read(dashboardControllerProvider).onTabTapped(4),
          child: UserAvatar(
            size: 48.w,
            fullName: fullName,
            avatarUrl: user?.avatarUrl,
          ),
        ),
        16.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              Text(
                AppStrings.dashboardHomeSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.travellerMutedText,
                ),
              ),
            ],
          ),
        ),
        16.pw,
        GestureDetector(
          onTap: () => AppRouterGo.push(notificationsView),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.travellerCardBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.travellerBorder),
                ),
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardHomeNotificationBellIcn,
                  width: 24.sp,
                  height: 24.sp,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryWhite,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.dashboardSosRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '2',
                    style: context.labelSmallStyle?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
