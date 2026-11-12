import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import '../widgets/payment_field.dart';
import '../widgets/payment_method_header.dart';
import '../widgets/saved_payment_method_card.dart';

class ProfilePaymentMethodView extends ConsumerWidget {
  const ProfilePaymentMethodView({super.key});

  void _showPaymentFields(BuildContext context, ProfileController controller) {
    controller.showPaymentFields();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) controller.paymentCardNumberFocusNode.requestFocus();
    });
  }

  void _addPaymentMethod(BuildContext context, ProfileController controller) {
    if (!controller.canAddPaymentMethod) return;
    FocusScope.of(context).unfocus();
    controller.addPaymentMethod();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.only(left: 32, right: 32, top: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PaymentMethodHeader(),
              24.ph,
              SavedPaymentMethodCard(
                cardNumber: controller.savedPaymentCardNumber,
                expiry: controller.savedPaymentCardExpiry,
                onEdit: () => _showPaymentFields(context, controller),
              ),
              24.ph,
              PrimaryElevatedButton(
                onTap: () => _showPaymentFields(context, controller),
                text: AppStrings.profileAddNewPaymentMethod,
              ),
              if (controller.showAddPaymentFields) ...[
                16.ph,
                PaymentField(
                  label: AppStrings.cardNumberLabel,
                  controller: controller.paymentCardNumberController,
                  focusNode: controller.paymentCardNumberFocusNode,
                  hintText: AppStrings.cardNumberHint,
                  keyboardType: TextInputType.number,
                  maxLength: 19,
                  inputFormatters: const [CardNumberInputFormatter()],
                  onChanged: controller.onPaymentFieldChanged,
                ),
                10.ph,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PaymentField(
                        label: AppStrings.profilePaymentExpiryLabel,
                        controller: controller.paymentExpiryController,
                        hintText: AppStrings.expiryDateHint,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        inputFormatters: [ExpiryDateInputFormatter()],
                        onChanged: controller.onPaymentFieldChanged,
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: PaymentField(
                        label: AppStrings.cvvLabel,
                        controller: controller.paymentCvvController,
                        hintText: AppStrings.profilePaymentCvvHint,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: controller.onPaymentFieldChanged,
                      ),
                    ),
                  ],
                ),
                16.ph,
                PrimaryElevatedButton(
                  onTap: () => _addPaymentMethod(context, controller),
                  text: AppStrings.profilePaymentAddButton,
                  enabled: controller.canAddPaymentMethod,
                ),
              ],
              24.ph,
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppStrings.profilePaymentMethodNote,
                  textAlign: TextAlign.center,
                  style: context.bodySmallStyle?.copyWith(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.coolGray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
