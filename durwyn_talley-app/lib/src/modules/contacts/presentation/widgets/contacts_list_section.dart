import '../../../../core/utils/app_exports.dart';
import '../controller/contacts_controller.dart';
import 'contact_card.dart';

class ContactsListSection extends ConsumerWidget {
  const ContactsListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsController = ref.watch(contactsControllerProvider);
    final plan = ref.watch(subscriptionControllerProvider).currentPlan;
    final contacts = contactsController.contacts;
    final isLimitReached = contacts.length >= plan.maxContacts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8.w,
                    runSpacing: 4.h,
                    children: [
                      Text(
                        AppStrings.dashboardContactsTitle,
                        style: context.headlineMediumStyle?.copyWith(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      Container(
                        padding:
                            AppInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isLimitReached
                              ? const Color(0xFFF59E0B)
                                  .withValues(alpha: 0.15)
                              : AppColors.successGreen.withValues(alpha: 0.15),
                          borderRadius: 8.circular,
                          border: Border.all(
                            color: isLimitReached
                                ? const Color(0xFFF59E0B)
                                  .withValues(alpha: 0.4)
                                : AppColors.successGreen.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          '${contacts.length}/${plan.maxContacts} Used',
                          style: context.labelSmallStyle?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: isLimitReached
                                ? const Color(0xFFF59E0B)
                                : AppColors.successGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.ph,
                  Text(
                    plan == SubscriptionPlan.free
                        ? 'Free Plan includes 1 trusted emergency contact.'
                        : '${plan.name.toUpperCase()} Plan allows up to ${plan.maxContacts} trusted emergency contacts.',
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.coolGray,
                    ),
                  ),
                ],
              ),
            ),
            12.pw,
            GestureDetector(
              onTap: () {
                if (isLimitReached) {
                  Prompts.showToast(
                    '${plan.name.toUpperCase()} Plan allows up to ${plan.maxContacts} emergency contacts. Upgrade plan to add more.',
                    isSuccess: false,
                  );
                } else {
                  AppRouterGo.push(addEmergencyContactView);
                }
              },
              child: Container(
                width: 44.w,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isLimitReached
                      ? AppColors.dashboardCardBg
                      : AppColors.successGreen,
                  shape: BoxShape.circle,
                  border: isLimitReached
                      ? Border.all(
                          color: AppColors.primaryWhite.withValues(alpha: 0.2),
                        )
                      : null,
                ),
                child: SvgPicture.asset(
                  AppAssetsSvg.dashboardContactsAddIcn,
                  width: 22.sp,
                  height: 22.sp,
                  colorFilter: ColorFilter.mode(
                    isLimitReached
                        ? AppColors.coolGray
                        : AppColors.dashboardBackground,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
        16.ph,
        if (contactsController.isLoading && !contactsController.hasLoaded)
          Center(
            child: Padding(
              padding: AppInsets.symmetric(vertical: 40),
              child: const CircularProgressIndicator(
                color: AppColors.successGreen,
              ),
            ),
          )
        else if (contacts.isEmpty)
          Container(
            width: double.infinity,
            padding: AppInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.dashboardCardBg,
              borderRadius: 16.circular,
              border: Border.all(
                color: AppColors.primaryWhite.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.dashboardContactsCallIcn,
                    width: 28.sp,
                    height: 28.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.successGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                16.ph,
                Text(
                  'No Emergency Contacts Yet',
                  style: context.titleMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
                8.ph,
                Text(
                  'Add a trusted person to be alerted with your live location during an emergency SOS.',
                  textAlign: TextAlign.center,
                  style: context.bodyMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.coolGray,
                  ),
                ),
                20.ph,
                PrimaryElevatedButton(
                  onTap: () => AppRouterGo.push(addEmergencyContactView),
                  text: 'Add Emergency Contact',
                  height: 46.h,
                ),
              ],
            ),
          )
        else
          for (final contact in contacts) ...[
            ContactCard(contact: contact),
            if (contact != contacts.last) 16.ph,
          ],
      ],
    );
  }
}
