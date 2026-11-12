import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';

class SosButton extends ConsumerWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: GestureDetector(
        onTap: () {
          ref.read(homeControllerProvider).startSosCountdown();
          AppRouterGo.push(sosActivationView);
        },
        child: Container(
          width: 192.w,
          height: 192.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.dashboardSosRed,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.dashboardSosLabel,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              4.ph,
              Text(
                AppStrings.dashboardSosSubtitle,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
