import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/payment_method_option_button.dart';
import '../widgets/sign_in_labeled_field.dart';

class PaymentMethodView extends ConsumerWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Form(
            key: controller.addCardFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    Text(
                      AppStrings.paymentMethodPageTitle,
                      style: context.headlineSmallStyle?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
                32.ph,
                PaymentMethodOptionButton(
                  icon: AppAssetsSvg.paymentMethodCardIcn,
                  label: AppStrings.paymentOptionCardPayment,
                  selected: controller.selectedPaymentMethod ==
                      PaymentMethod.card,
                  onTap: () =>
                      controller.selectPaymentMethod(PaymentMethod.card),
                ),
                10.ph,
                PaymentMethodOptionButton(
                  icon: AppAssetsSvg.paymentMethodApplePayIcn,
                  label: AppStrings.paymentOptionApplePay,
                  selected: controller.selectedPaymentMethod ==
                      PaymentMethod.applePay,
                  onTap: () =>
                      controller.selectPaymentMethod(PaymentMethod.applePay),
                ),
                10.ph,
                PaymentMethodOptionButton(
                  icon: AppAssetsSvg.paymentMethodGooglePayIcn,
                  label: AppStrings.paymentOptionGooglePay,
                  selected: controller.selectedPaymentMethod ==
                      PaymentMethod.googlePay,
                  tintIcon: false,
                  onTap: () =>
                      controller.selectPaymentMethod(PaymentMethod.googlePay),
                ),
                if (controller.selectedPaymentMethod ==
                    PaymentMethod.card) ...[
                  24.ph,
                  Container(
                    height: 1,
                    color: AppColors.primaryWhite.withValues(alpha: 0.1),
                  ),
                  24.ph,
                  Text(
                    AppStrings.addNewCardTitle,
                    style: context.titleLargeStyle?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  16.ph,
                  SignInLabeledField(
                    label: AppStrings.addCardHolderNameLabel,
                    controller: controller.cardHolderNameController,
                    hintText: AppStrings.addCardHolderNameHint,
                    validator: AppValidators.validateFullName,
                  ),
                  16.ph,
                  SignInLabeledField(
                    label: AppStrings.addCardNumberLabel,
                    controller: controller.cardNumberController,
                    hintText: AppStrings.addCardNumberHint,
                    textInputType: TextInputType.number,
                    validator: AppValidators.validateCardNumber,
                  ),
                  16.ph,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SignInLabeledField(
                          label: AppStrings.addCardExpiryDateLabel,
                          controller: controller.cardExpiryDateController,
                          hintText: AppStrings.addCardExpiryDateHint,
                          validator: AppValidators.validateExpiryDate,
                        ),
                      ),
                      16.pw,
                      Expanded(
                        child: SignInLabeledField(
                          label: AppStrings.addCardCvvLabel,
                          controller: controller.cardCvvController,
                          hintText: AppStrings.addCardCvvHint,
                          textInputType: TextInputType.number,
                          validator: AppValidators.validateCVV,
                        ),
                      ),
                    ],
                  ),
                  16.ph,
                  SignInLabeledField(
                    label: AppStrings.addCardBillingAddressLabel,
                    controller: controller.cardBillingAddressController,
                    hintText: AppStrings.addCardBillingAddressHint,
                    validator: (value) => AppValidators.validateEmpty(
                      value,
                      'Please enter your billing address',
                    ),
                  ),
                  16.ph,
                  GestureDetector(
                    onTap: controller.toggleSaveCardForFuturePayments,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            borderRadius: 2.circular,
                            color: controller.saveCardForFuturePayments
                                ? AppColors.successGreen
                                : AppColors.transparent,
                            border: Border.all(
                              color: controller.saveCardForFuturePayments
                                  ? AppColors.successGreen
                                  : AppColors.primaryWhite,
                            ),
                          ),
                          child: controller.saveCardForFuturePayments
                              ? Icon(
                                  Icons.check,
                                  size: 14.sp,
                                  color: AppColors.splashScrimColor,
                                )
                              : null,
                        ),
                        12.pw,
                        Text(
                          AppStrings.saveCardForFuturePayments,
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                24.ph,
                PrimaryElevatedButton(
                  onTap: controller.activateSubscription,
                  text: AppStrings.activateSubscriptionButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
