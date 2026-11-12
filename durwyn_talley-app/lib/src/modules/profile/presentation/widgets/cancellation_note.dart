import '../../../../core/utils/app_exports.dart';

class CancellationNote extends StatelessWidget {
  const CancellationNote({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        AppStrings.manageSubscriptionCancellationNote,
        textAlign: TextAlign.center,
        style: context.bodySmallStyle?.copyWith(
          fontSize: 14.sp,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          color: AppColors.coolGray,
        ),
      ),
    );
  }
}
