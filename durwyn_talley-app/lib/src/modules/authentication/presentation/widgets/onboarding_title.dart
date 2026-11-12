import '../../../../core/utils/app_exports.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: context.headlineLargeStyle?.copyWith(
        fontSize: 30.sp,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryWhite,
      ),
    );
  }
}
