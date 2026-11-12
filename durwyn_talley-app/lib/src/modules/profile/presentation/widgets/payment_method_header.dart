import '../../../../core/utils/app_exports.dart';

class PaymentMethodHeader extends StatelessWidget {
  const PaymentMethodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: AppRouterGo.back,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColors.primaryWhite,
              ),
              8.pw,
              Text(
                AppStrings.back,
                style: context.labelMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ),
        30.pw,
        Expanded(
          child: Text(
            AppStrings.profilePaymentMethodTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleLargeStyle?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ],
    );
  }
}
