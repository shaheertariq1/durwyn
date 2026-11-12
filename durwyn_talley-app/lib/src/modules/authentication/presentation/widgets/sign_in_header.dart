import '../../../../core/utils/app_exports.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150.w,
          height: 150.h,
          padding: AppInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.primaryWhite,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            AppAssetsPng.onboardingShieldLogo,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        16.ph,
        Text(
          AppStrings.welcomeBack,
          style: context.headlineLargeStyle?.copyWith(
            fontSize: 30.sp,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryWhite,
          ),
        ),
        16.ph,
        Text(
          AppStrings.signInToContinue,
          textAlign: TextAlign.center,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhite.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
