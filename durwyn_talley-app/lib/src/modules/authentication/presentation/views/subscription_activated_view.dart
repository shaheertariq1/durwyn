import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/summary_row.dart';

class SubscriptionActivatedView extends ConsumerWidget {
  const SubscriptionActivatedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssetsSvg.subscriptionActivatedCheckIcn,
                width: 96.w,
                height: 96.h,
              ),
              10.ph,
              Text(
                AppStrings.subscriptionActivatedTitle,
                textAlign: TextAlign.center,
                style: context.headlineMediumStyle?.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryWhite,
                ),
              ),
              8.ph,
              Text(
                AppStrings.subscriptionActivatedSubtitle,
                textAlign: TextAlign.center,
                style: context.bodyMediumStyle?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.coolGray,
                ),
              ),
              24.ph,
              Container(
                width: double.infinity,
                padding: AppInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.otpFieldFill,
                  borderRadius: 16.circular,
                ),
                child: Column(
                  children: [
                    SummaryRow(
                      label: AppStrings.subscriptionActivatedPlanLabel,
                      value: AppStrings.subscriptionActivatedPlanValue,
                    ),
                    12.ph,
                    SummaryRow(
                      label: AppStrings.subscriptionActivatedAmountLabel,
                      value: AppStrings.subscriptionActivatedAmountValue,
                    ),
                    12.ph,
                    SummaryRow(
                      label: AppStrings.subscriptionActivatedNextBillingLabel,
                      value: AppStrings.subscriptionActivatedNextBillingValue,
                    ),
                  ],
                ),
              ),
              24.ph,
              PrimaryElevatedButton(
                onTap: controller.continueToApp,
                text: AppStrings.continueToAppButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
