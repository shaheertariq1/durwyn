import '../../../../core/utils/app_exports.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      height: 220.h,
      padding: AppInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.primaryWhite,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        AppAssetsPng.onboardingShieldLogo,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
