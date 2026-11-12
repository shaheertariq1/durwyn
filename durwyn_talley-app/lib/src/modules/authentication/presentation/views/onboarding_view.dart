import '../../../../core/utils/app_exports.dart';
import '../controller/authentication_controller.dart';
import '../widgets/onboarding_slide.dart';

class OnboardingView extends ConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authenticationControllerProvider);
    final slides = AuthenticationController.slides;

    return Scaffold(
      backgroundColor: AppColors.splashScrimColor,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: slides.length,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          return OnboardingSlide(
            data: slides[index],
            total: slides.length,
            currentIndex: controller.currentIndex,
            isFirst: index == 0,
            isLast: index == slides.length - 1,
            onSkip: controller.skip,
            onNext: controller.next,
          );
        },
      ),
    );
  }
}
