import '../../../../core/utils/app_exports.dart';

class ContactsAutoCallBanner extends StatelessWidget {
  const ContactsAutoCallBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: AppInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.dashboardContactsBannerBg,
        borderRadius: 16.circular,
        border: Border.all(color: AppColors.dashboardContactsBannerBorder),
      ),
      child: Text(
        AppStrings.dashboardContactsAutoCallBannerText,
        textAlign: TextAlign.center,
        style: context.bodySmallStyle?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryWhite,
        ),
      ),
    );
  }
}
