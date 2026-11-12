import '../../../../core/utils/app_exports.dart';

class CancelSubscriptionDialog extends StatelessWidget {
  const CancelSubscriptionDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierColor: AppColors.primaryblack.withValues(alpha: 0.5),
      builder: (context) => const CancelSubscriptionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      insetPadding: AppInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        padding: AppInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.dashboardBackground,
          borderRadius: 32.circular,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryblack.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.manageSubscriptionCancelIconBg,
                borderRadius: 32.circular,
              ),
              child: SvgPicture.asset(
                AppAssetsSvg.manageSubscriptionCancelAlertIcn,
                width: 32.sp,
                height: 32.sp,
                colorFilter: const ColorFilter.mode(
                  AppColors.manageSubscriptionCancelRed,
                  BlendMode.srcIn,
                ),
              ),
            ),
            24.ph,
            Text(
              AppStrings.manageSubscriptionCancelDialogTitle,
              textAlign: TextAlign.center,
              style: context.headlineMediumStyle?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryWhite,
              ),
            ),
            12.ph,
            Text(
              AppStrings.manageSubscriptionCancelDialogDescription,
              textAlign: TextAlign.center,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 15.sp,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryWhite.withValues(alpha: 0.8),
              ),
            ),
            24.ph,
            GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: AppInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.manageSubscriptionCancelRed,
                  borderRadius: 10.circular,
                ),
                child: Text(
                  AppStrings.manageSubscriptionCancel,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
              ),
            ),
            12.ph,
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: AppInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: 10.circular,
                  border: Border.all(width: 1, color: AppColors.primaryWhite),
                ),
                child: Text(
                  AppStrings.manageSubscriptionKeep,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 16.sp,
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
