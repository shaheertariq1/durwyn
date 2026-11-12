import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/controller/authentication_controller.dart';

class HomeMapCard extends ConsumerWidget {
  const HomeMapCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticationControllerProvider).currentUser;
    final fullName = user?.fullName.trim() ?? '';
    final firstName = fullName.isNotEmpty ? fullName.split(' ').first : '';
    final label = firstName.isNotEmpty ? firstName : AppStrings.dashboardMapLocationLabel;

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 240.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: 16.circular),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppAssetsPng.dashboardHomeMapBg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssetsSvg.dashboardHomeMapPinIcn,
                  width: 40.sp,
                  height: 40.sp,
                ),
                10.ph,
                Container(
                  padding: AppInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardMapLabelBg,
                    borderRadius: 4.circular,
                  ),
                  child: Text(
                    label,
                    style: context.labelSmallStyle?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryWhite.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16.w,
              bottom: 16.h,
              child: SvgPicture.asset(
                AppAssetsSvg.dashboardHomeLocationFillIcn,
                width: 20.sp,
                height: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
