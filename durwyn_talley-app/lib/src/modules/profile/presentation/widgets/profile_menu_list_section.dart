import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';
import '../../../home/presentation/widgets/premium_feature_sheet.dart';
import '../../domain/entities/profile_menu_item_entity.dart';
import '../../domain/entities/profile_menu_section_entity.dart';
import 'profile_logout_button.dart';
import 'profile_menu_section_card.dart';

class ProfileMenuListSection extends ConsumerWidget {
  const ProfileMenuListSection({super.key});

  static List<ProfileMenuSectionEntity> _sections(
    BuildContext context,
    bool isFreePlan,
    AuthenticationController authenticationController,
  ) => [
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfileSubscriptionSectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileCurrentPlanIcn,
          label: AppStrings.dashboardProfileCurrentPlan,
          trailingText: isFreePlan
              ? AppStrings.freePlanName
              : AppStrings.dashboardProfileMembershipTitle,
          onTap: () => AppRouterGo.push(manageSubscriptionView),
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileComparePlansIcn,
          label: AppStrings.dashboardProfileComparePlans,
          onTap: () => AppRouterGo.push(changePlanView),
        ),
        if (isFreePlan)
          ProfileMenuItemEntity(
            icon: AppAssetsSvg.dashboardPremiumSheetBoltIcn,
            label: AppStrings.dashboardProfileUpgradePlan,
            labelColor: AppColors.successGreen,
            onTap: () => AppRouterGo.push(changePlanView),
          )
        else ...[
          ProfileMenuItemEntity(
            icon: AppAssetsSvg.dashboardProfileChangePlanIcn,
            label: AppStrings.dashboardProfileChangePlan,
            onTap: () => AppRouterGo.push(changePlanView),
          ),
          ProfileMenuItemEntity(
            icon: AppAssetsSvg.dashboardProfileCardIcn,
            label: AppStrings.dashboardProfilePaymentMethod,
            trailingText: AppStrings.dashboardProfilePaymentMethodMasked,
            onTap: () => AppRouterGo.push(profilePaymentMethodView),
          ),
        ],
      ],
    ),
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfileAccountSectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileEditIcn,
          label: AppStrings.dashboardProfileEditProfile,
          onTap: () => AppRouterGo.push(editProfileView),
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileLockIcn,
          label: AppStrings.dashboardProfileChangePassword,
          onTap: () => AppRouterGo.push(changePasswordView),
        ),
      ],
    ),
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfileSafetySectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileMicIcn,
          label: AppStrings.dashboardProfileManageVoiceTrigger,
          trailingText: isFreePlan ? 'STANDARD+' : null,
          onTap: isFreePlan
              ? () => PremiumFeatureSheet.show(
                    context,
                    featureName: AppStrings.dashboardProfileManageVoiceTrigger,
                  )
              : authenticationController.startManageVoiceTrigger,
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileGearIcn,
          label: AppStrings.dashboardProfileManagePermissions,
          onTap: authenticationController.startManagePermissions,
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileShieldOutlineIcn,
          label: AppStrings.dashboardProfileEmergencyPreferences,
          onTap: () => AppRouterGo.push(emergencyPreferencesView),
        ),
      ],
    ),
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfileSubscriptionSectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileCardIcn,
          label: AppStrings.dashboardProfileManageSubscription,
          onTap: () => AppRouterGo.push(manageSubscriptionView),
        ),
      ],
    ),
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfilePreferencesSectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileBellIcn,
          label: AppStrings.dashboardProfileNotificationSettings,
          onTap: () => AppRouterGo.push(notificationSettingsView),
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileShieldOutlineIcn,
          label: AppStrings.dashboardProfilePrivacyControls,
          onTap: () => AppRouterGo.push(privacyControlsView),
        ),
      ],
    ),
    ProfileMenuSectionEntity(
      title: AppStrings.dashboardProfileSupportSectionLabel,
      items: [
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileHelpIcn,
          label: AppStrings.dashboardProfileHelpCenter,
          onTap: () => AppRouterGo.push(helpCenterView),
        ),
        ProfileMenuItemEntity(
          icon: AppAssetsSvg.dashboardProfileChatIcn,
          label: AppStrings.dashboardProfileSupportChat,
          onTap: () => AppRouterGo.push(supportChatView),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFreePlan = ref.watch(subscriptionControllerProvider).isFreePlan;
    final authenticationController = ref.watch(
      authenticationControllerProvider,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final section in _sections(
          context,
          isFreePlan,
          authenticationController,
        )) ...[
          ProfileMenuSectionCard(section: section),
          16.ph,
        ],
        const ProfileLogoutButton(),
        16.ph,
        Center(
          child: Text(
            AppStrings.dashboardProfileVersion,
            style: context.bodyMediumStyle?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.coolGray,
            ),
          ),
        ),
      ],
    );
  }
}
