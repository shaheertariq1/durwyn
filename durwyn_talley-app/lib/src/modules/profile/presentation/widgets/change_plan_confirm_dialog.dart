import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';

class ChangePlanConfirmDialog extends ConsumerWidget {
  const ChangePlanConfirmDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: AppColors.primaryblack.withValues(alpha: 0.5),
      builder: (context) => const ChangePlanConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      insetPadding: AppInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: AppInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.dashboardBackground,
          borderRadius: 16.circular,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryblack.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.successGreen,
                borderRadius: 24.circular,
              ),
              child: Icon(
                Icons.done_all,
                size: 24.sp,
                color: AppColors.primaryWhite,
              ),
            ),
            24.ph,
            Text(
              AppStrings.changePlanConfirmDialogTitle,
              textAlign: TextAlign.center,
              style: context.titleLargeStyle?.copyWith(
                fontSize: 20.sp,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryWhite,
              ),
            ),
            8.ph,
            Text(
              AppStrings.changePlanConfirmDialogDescription,
              textAlign: TextAlign.center,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 14.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryWhite,
              ),
            ),
            32.ph,
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                await ref.read(profileControllerProvider).confirmChangePlan();
                AppRouterGo.back();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  borderRadius: 8.circular,
                ),
                child: Text(
                  AppStrings.changePlanConfirmDialogAction,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
