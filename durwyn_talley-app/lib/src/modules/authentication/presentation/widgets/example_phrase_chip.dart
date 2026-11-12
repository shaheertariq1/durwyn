import '../../../../core/utils/app_exports.dart';

class ExamplePhraseChip extends StatelessWidget {
  const ExamplePhraseChip({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.choosePlanNeutralChip,
          borderRadius: 12.circular,
        ),
        child: Text(
          label,
          style: context.labelMediumStyle?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
