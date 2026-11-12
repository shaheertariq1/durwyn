import '../../../../core/utils/app_exports.dart';
import '../controller/home_controller.dart';

class SosActivationView extends ConsumerWidget {
  const SosActivationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.dashboardSosRed,
      body: SafeArea(
        child: Padding(
          padding: AppInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 192.w,
                height: 192.h,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryWhite,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${controller.sosSecondsRemaining}',
                  style: context.headlineLargeStyle?.copyWith(
                    fontSize: 110.sp,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: AppColors.dashboardSosRed,
                  ),
                ),
              ),
              24.ph,
              Text(
                controller.sosActivated
                    ? AppStrings.dashboardSosActivatedTitle
                    : AppStrings.dashboardSosActivatingTitle,
                textAlign: TextAlign.center,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              8.ph,
              Text(
                AppStrings.dashboardSosActivatingContactsNotice,
                textAlign: TextAlign.center,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryWhite.withValues(alpha: 0.9),
                ),
              ),
              4.ph,
              Text(
                AppStrings.dashboardSosActivatingDetailsNotice,
                textAlign: TextAlign.center,
                style: context.bodySmallStyle?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryWhite.withValues(alpha: 0.8),
                ),
              ),
              48.ph,
              GestureDetector(
                onTap: controller.cancelSosActivation,
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryWhite,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.dashboardSosActivatingCloseIcn,
                    width: 40.sp,
                    height: 40.sp,
                  ),
                ),
              ),
              16.ph,
              Text(
                controller.sosActivated
                    ? AppStrings.dashboardSosActivatingStopLabel
                    : AppStrings.dashboardSosActivatingCancelLabel,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
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
