import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/onboarding_slide_data.dart';
import 'onboarding_logo.dart';
import 'onboarding_page_indicator.dart';
import 'onboarding_subtitle.dart';
import 'onboarding_title.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.data,
    required this.total,
    required this.currentIndex,
    required this.isFirst,
    required this.isLast,
    required this.onSkip,
    required this.onNext,
  });

  final OnboardingSlideData data;
  final int total;
  final int currentIndex;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(data.background, fit: BoxFit.cover),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.4, 1],
              colors: [
                AppColors.splashScrimColor.withValues(alpha: 0),
                AppColors.black50,
                AppColors.splashScrimColor,
              ],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: AppInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                44.ph,
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onSkip,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      AppStrings.skip,
                      style: GoogleFonts.outfit(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryWhite,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                24.ph,
                Expanded(
                  child: isFirst
                      ? Column(
                          children: [
                            const OnboardingLogo(),
                            const Expanded(child: SizedBox.shrink()),
                            OnboardingTitle(title: data.title),
                            16.ph,
                            OnboardingSubtitle(subtitle: data.subtitle),
                          ],
                        )
                      : Column(
                          children: [
                            const Expanded(child: SizedBox.shrink()),
                            const OnboardingLogo(),
                            16.ph,
                            OnboardingTitle(title: data.title),
                            16.ph,
                            OnboardingSubtitle(subtitle: data.subtitle),
                          ],
                        ),
                ),
                64.ph,
                OnboardingPageIndicator(
                  length: total,
                  currentIndex: currentIndex,
                ),
                14.ph,
                PrimaryElevatedButton(
                  onTap: onNext,
                  text: isLast
                      ? AppStrings.onboardingGetStartedLabel
                      : AppStrings.next,
                  trailingWidget: SvgPicture.asset(
                    AppAssetsSvg.onboardingNextArrowIcn,
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
                40.ph,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
