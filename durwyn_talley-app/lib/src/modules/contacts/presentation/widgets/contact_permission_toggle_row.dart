import '../../../../core/utils/app_exports.dart';
import '../../../profile/presentation/widgets/settings_toggle_switch.dart';

class ContactPermissionToggleRow extends StatelessWidget {
  const ContactPermissionToggleRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyMediumStyle?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryWhite,
          ),
        ),
        SettingsToggleSwitch(label: label, value: value, onChanged: onChanged),
      ],
    );
  }
}
