import '../../../../core/utils/app_exports.dart';

class WaveformPlaybackRow extends StatelessWidget {
  const WaveformPlaybackRow({
    super.key,
    required this.isPlaying,
    required this.onTap,
  });

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (_) => SvgPicture.asset(
                AppAssetsSvg.voiceTriggerWaveformIcn,
                height: 40.h,
              ),
            ),
          ),
        ),
        12.pw,
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44.w,
            height: 44.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isPlaying
                    ? AppColors.primaryRed
                    : AppColors.primaryWhite.withValues(alpha: 0.2),
              ),
            ),
            child: SvgPicture.asset(
              AppAssetsSvg.voiceTriggerPlayIcn,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ],
    );
  }
}
