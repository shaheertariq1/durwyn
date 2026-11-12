import '../../../../core/utils/app_exports.dart';

class SettingsToggleSwitch extends StatelessWidget {
  const SettingsToggleSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      toggled: value,
      button: true,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 48.w,
          height: 24.h,
          padding: AppInsets.all(2),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: value
                ? AppColors.successGreen
                : AppColors.choosePlanNeutralChip,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
