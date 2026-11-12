import '../../../../components/image_source_sheet.dart';
import '../../../../core/utils/app_exports.dart';
import '../../../authentication/presentation/widgets/sign_in_labeled_field.dart';
import '../widgets/emergency_permission_checkbox_row.dart';

import '../controller/contacts_controller.dart';

class AddEmergencyContactView extends ConsumerStatefulWidget {
  const AddEmergencyContactView({super.key});

  @override
  ConsumerState<AddEmergencyContactView> createState() =>
      _AddEmergencyContactViewState();
}

class _AddEmergencyContactViewState
    extends ConsumerState<AddEmergencyContactView> {
  static const List<String> _relationshipOptions = [
    'Parent',
    'Sibling',
    'Spouse/Partner',
    'Child',
    'Friend',
    'Relative',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  File? _avatar;
  String? _relationship;
  bool _allowGps = true;
  bool _allowAudio = true;
  bool _allowVideo = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      final plan = ref.read(subscriptionControllerProvider).currentPlan;
      final success = await ref.read(contactsControllerProvider).addContact(
            name: _fullNameController.text,
            phone: _phoneNumberController.text,
            relationship: _relationship ?? 'Family',
            email: _emailController.text,
            allowGps: _allowGps,
            allowAudio: _allowAudio,
            allowVideo: _allowVideo,
            plan: plan,
          );
      if (success && mounted) {
        AppRouterGo.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: AppRouterGo.back,
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20.sp,
                            color: AppColors.primaryWhite,
                          ),
                          8.pw,
                          Text(
                            AppStrings.back,
                            style: context.labelMediumStyle?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.pw,
                    Text(
                      AppStrings.addEmergencyContactTitle,
                      style: context.titleLargeStyle?.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ],
                ),
                32.ph,
                Center(
                  child: GestureDetector(
                    onTap: () => ImageSourceSheet.show(
                      context,
                      isDark: true,
                      onPicked: (file) => setState(() => _avatar = file),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 112.w,
                          height: 112.h,
                          decoration: BoxDecoration(
                            color: AppColors.otpFieldFill,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryWhite.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ),
                          child: _avatar == null
                              ? Center(
                                  child: SvgPicture.asset(
                                    AppAssetsSvg
                                        .completeProfileAvatarPlaceholderIcn,
                                    width: 48.w,
                                    height: 48.h,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    _avatar!,
                                    width: 112.w,
                                    height: 112.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.dashboardCardBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.dashboardBackground,
                              ),
                            ),
                            child: SvgPicture.asset(
                              AppAssetsSvg.imageSourceCameraIcn,
                              width: 20.w,
                              height: 20.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryWhite,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                32.ph,
                SignInLabeledField(
                  label: AppStrings.fullName,
                  controller: _fullNameController,
                  hintText: AppStrings.fullNameHint,
                  validator: AppValidators.validateFullName,
                ),
                16.ph,
                SignInLabeledField(
                  label: AppStrings.phoneNumber,
                  controller: _phoneNumberController,
                  hintText: AppStrings.phoneHint,
                  helperText: AppStrings.phoneInstruction,
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                  ],
                  validator: AppValidators.validatePhoneNumber,
                ),
                16.ph,
                SignInLabeledField(
                  label: AppStrings.emailAddress,
                  controller: _emailController,
                  hintText: AppStrings.emailHint,
                  textInputType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmail,
                ),
                16.ph,
                Text(
                  AppStrings.addEmergencyContactRelationship,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.signInFieldLabel,
                  ),
                ),
                10.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: 16.circular,
                    border: Border.all(
                      color: AppColors.primaryWhite.withValues(alpha: 0.2),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _relationship,
                      isExpanded: true,
                      hint: Text(
                        AppStrings.addEmergencyContactRelationshipHint,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryWhite.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      dropdownColor: AppColors.dashboardCardBg,
                      borderRadius: 16.circular,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: AppColors.primaryWhite,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryWhite,
                      ),
                      onChanged: (option) =>
                          setState(() => _relationship = option),
                      items: [
                        for (final option in _relationshipOptions)
                          DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ),
                      ],
                    ),
                  ),
                ),
                24.ph,
                Text(
                  AppStrings.addEmergencyContactPermissionsTitle,
                  style: context.labelMediumStyle?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhite,
                  ),
                ),
                16.ph,
                EmergencyPermissionCheckboxRow(
                  label: AppStrings.addEmergencyContactAllowGps,
                  value: _allowGps,
                  onChanged: (value) => setState(() => _allowGps = value),
                ),
                10.ph,
                EmergencyPermissionCheckboxRow(
                  label: AppStrings.addEmergencyContactAllowAudio,
                  value: _allowAudio,
                  onChanged: (value) => setState(() => _allowAudio = value),
                ),
                10.ph,
                EmergencyPermissionCheckboxRow(
                  label: AppStrings.addEmergencyContactAllowVideo,
                  value: _allowVideo,
                  onChanged: (value) => setState(() => _allowVideo = value),
                ),
                32.ph,
                PrimaryElevatedButton(
                  loader: ref.watch(contactsControllerProvider).isLoading,
                  onTap: _saveContact,
                  text: AppStrings.addEmergencyContactSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
