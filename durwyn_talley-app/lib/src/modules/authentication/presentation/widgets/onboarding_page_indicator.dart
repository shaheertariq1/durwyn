import '../../../../core/utils/app_exports.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: AppInsets.only(right: index == length - 1 ? 0 : 8),
          width: isActive ? 35.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.successGreen : AppColors.primaryWhite,
            borderRadius: 16.circular,
          ),
        );
      }),
    );
  }
}
