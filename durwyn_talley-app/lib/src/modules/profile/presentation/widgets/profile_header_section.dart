import '../../../../components/image_source_sheet.dart';
import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';

class ProfileHeaderSection extends ConsumerWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCtrl = ref.watch(subscriptionControllerProvider);
    final isFreePlan = subCtrl.isFreePlan;
    final currentPlan = subCtrl.currentPlan;

    final authCtrl = ref.watch(authenticationControllerProvider);
    final user = authCtrl.currentUser;
    final fullName = (user?.fullName.isNotEmpty == true)
        ? user!.fullName
        : AppStrings.dashboardProfileName;
    final email = (user?.email.isNotEmpty == true)
        ? user!.email
        : AppStrings.dashboardProfileEmail;
    final phone = (user?.phoneNumber.isNotEmpty == true)
        ? user!.phoneNumber
        : '';

    final topSafeArea = MediaQuery.paddingOf(context).top;

    final String planTitle;
    switch (currentPlan) {
      case SubscriptionPlan.premium:
        planTitle = AppStrings.dashboardProfileMembershipTitle;
        break;
      case SubscriptionPlan.standard:
        planTitle = 'Standard Member';
        break;
      case SubscriptionPlan.free:
        planTitle = AppStrings.freePlanName;
        break;
    }

    final planSubtitle = isFreePlan
        ? AppStrings.dashboardProfileFreePlanSubtitle
        : AppStrings.dashboardProfileMembershipSubtitle;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topSafeArea,
        bottom: 24.h,
        left: 24.w,
        right: 24.w,
      ),
      color: AppColors.dashboardCardBg,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => ImageSourceSheet.show(
                  context,
                  isDark: true,
                  onPicked: (file) =>
                      ref.read(profileAvatarControllerProvider).setAvatar(file),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserAvatar(
                      size: 80.w,
                      fullName: fullName,
                      avatarUrl: user?.avatarUrl,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 26.w,
                        height: 26.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.dashboardCardBg,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.dashboardBackground,
                            width: 2,
                          ),
                        ),
                        child: SvgPicture.asset(
                          AppAssetsSvg.imageSourceCameraIcn,
                          width: 13.sp,
                          height: 13.sp,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: context.headlineMediumStyle?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                    4.ph,
                    Text(
                      email,
                      style: context.bodyMediumStyle?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.coolGray,
                      ),
                    ),
                    if (phone.isNotEmpty) ...[
                      2.ph,
                      Text(
                        phone,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          16.ph,
          GestureDetector(
            onTap: isFreePlan ? () => AppRouterGo.push(changePlanView) : null,
            child: Container(
              width: double.infinity,
              padding: AppInsets.symmetric(horizontal: 17, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.dashboardProtectionBannerBg,
                borderRadius: 16.circular,
                border: Border.all(
                  color: AppColors.dashboardProtectionBannerBorder,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planTitle,
                          style: context.labelMediumStyle?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.successGreen,
                          ),
                        ),
                        Text(
                          planSubtitle,
                          style: context.bodySmallStyle?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dashboardProtectionSubtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    isFreePlan
                        ? AppAssetsSvg.dashboardPremiumSheetBoltIcn
                        : AppAssetsSvg.dashboardProfilePremiumShieldIcn,
                    width: 24.sp,
                    height: 24.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
