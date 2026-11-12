import '../../../../core/utils/app_exports.dart';
import 'subscription_card.dart';
import 'subscription_card_title.dart';

class SubscriptionFeaturesCard extends StatelessWidget {
  const SubscriptionFeaturesCard({
    super.key,
    this.title = AppStrings.manageSubscriptionFeaturesTitle,
    this.features = AppStrings.manageSubscriptionFeatures,
  });

  final String title;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return SubscriptionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubscriptionCardTitle(title: title),
          16.ph,
          for (final feature in features) ...[
            Row(
              children: [
                Container(
                  width: 20.sp,
                  height: 20.sp,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.successGreen,
                  ),
                  child: SvgPicture.asset(
                    AppAssetsSvg.choosePlanCheckIcn,
                    width: 12.sp,
                    height: 12.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColors.dashboardBackground,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                12.pw,
                Expanded(
                  child: Text(
                    feature,
                    style: context.bodyMediumStyle?.copyWith(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ],
            ),
            if (feature != features.last) 8.ph,
          ],
        ],
      ),
    );
  }
}
