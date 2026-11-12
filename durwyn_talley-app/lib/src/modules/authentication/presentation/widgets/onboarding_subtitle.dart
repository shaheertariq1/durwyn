import '../../../../core/utils/app_exports.dart';

class OnboardingSubtitle extends StatelessWidget {
  const OnboardingSubtitle({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: context.bodyLargeStyle?.copyWith(
        fontSize: 18.sp,
        height: 1.67,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryWhite.withValues(alpha: 0.6),
      ),
    );
  }
}
