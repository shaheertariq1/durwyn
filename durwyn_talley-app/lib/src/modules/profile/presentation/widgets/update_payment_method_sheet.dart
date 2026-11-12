import '../../../../core/utils/app_exports.dart';
import '../controller/profile_controller.dart';
import 'update_payment_field.dart';

class UpdatePaymentMethodSheet extends ConsumerWidget {
  const UpdatePaymentMethodSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileControllerProvider);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: AppInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.manageSubscriptionUpdatePaymentMethod,
                    style: context.titleMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: AppInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 20.sp,
                      color: AppColors.coolGray,
                    ),
                  ),
                ),
              ],
            ),
            16.ph,
            UpdatePaymentField(
              label: AppStrings.cardNumberLabel,
              controller: controller.subscriptionSheetCardNumberController,
              hintText: AppStrings.cardNumberHint,
              keyboardType: TextInputType.number,
              maxLength: 19,
              contentPadding: AppInsets.symmetric(
                horizontal: 17,
                vertical: 17,
              ),
              inputFormatters: const [CardNumberInputFormatter()],
            ),
            10.ph,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: UpdatePaymentField(
                    label: AppStrings.profilePaymentExpiryLabel,
                    controller: controller.subscriptionSheetExpiryController,
                    hintText: AppStrings.expiryDateHint,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    inputFormatters: [ExpiryDateInputFormatter()],
                  ),
                ),
                10.pw,
                Expanded(
                  child: UpdatePaymentField(
                    label: AppStrings.cvvLabel,
                    controller: controller.subscriptionSheetCvvController,
                    hintText: AppStrings.profilePaymentCvvHint,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            16.ph,
            PrimaryElevatedButton(
              onTap: () {
                if (controller.updateSubscriptionPaymentMethod()) {
                  Navigator.of(context).pop(true);
                }
              },
              text: AppStrings.manageSubscriptionUpdateCard,
              textColor: AppColors.dashboardBackground,
              style: context.bodyMediumStyle?.copyWith(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: AppColors.dashboardBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
