import '../../../../core/utils/app_exports.dart';
import '../../domain/entities/contact_entity.dart';
import '../widgets/contact_info_tile.dart';
import '../widgets/contact_permission_toggle_row.dart';

import '../controller/contacts_controller.dart';

class ContactDetailsView extends ConsumerStatefulWidget {
  const ContactDetailsView({super.key, required this.contact});

  final ContactEntity contact;

  @override
  ConsumerState<ContactDetailsView> createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends ConsumerState<ContactDetailsView> {
  late bool _allowGps = widget.contact.allowGps;
  late bool _allowAudio = widget.contact.allowAudio;
  late bool _allowVideo = widget.contact.allowVideo;

  Future<void> _updatePermission({
    bool? allowGps,
    bool? allowAudio,
    bool? allowVideo,
  }) async {
    setState(() {
      if (allowGps != null) _allowGps = allowGps;
      if (allowAudio != null) _allowAudio = allowAudio;
      if (allowVideo != null) _allowVideo = allowVideo;
    });

    final id = widget.contact.id;
    if (id != null) {
      await ref.read(contactsControllerProvider).updateContact(
            contactId: id,
            name: widget.contact.name,
            phone: widget.contact.phone,
            relationship: widget.contact.relationship,
            email: widget.contact.email,
            allowGps: _allowGps,
            allowAudio: _allowAudio,
            allowVideo: _allowVideo,
          );
    }
  }

  Future<void> _deleteContact() async {
    final id = widget.contact.id;
    if (id != null) {
      final success =
          await ref.read(contactsControllerProvider).deleteContact(id);
      if (success && mounted) {
        AppRouterGo.back();
      }
    } else {
      AppRouterGo.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact = widget.contact;
    final isDeleting = ref.watch(contactsControllerProvider).isLoading;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppInsets.symmetric(horizontal: 32, vertical: 24),
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
                          SvgPicture.asset(
                            AppAssetsSvg.dashboardGpsHistoryBackIcn,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                          8.pw,
                          Text(
                            AppStrings.back,
                            style: context.labelMediumStyle?.copyWith(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.contactDetailsTitle,
                        textAlign: TextAlign.center,
                        style: context.titleLargeStyle?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                    ),
                    24.pw,
                  ],
                ),
                24.ph,
                Center(
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          contact.avatar,
                          width: 96.w,
                          height: 96.h,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 96.w,
                            height: 96.h,
                            color: AppColors.dashboardCardBg,
                            child: Icon(
                              Icons.person,
                              size: 48.sp,
                              color: AppColors.coolGray,
                            ),
                          ),
                        ),
                      ),
                      16.ph,
                      Text(
                        contact.name,
                        style: context.headlineMediumStyle?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      4.ph,
                      Text(
                        contact.relationship,
                        style: context.bodyMediumStyle?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.coolGray,
                        ),
                      ),
                    ],
                  ),
                ),
                24.ph,
                ContactInfoTile(
                  icon: AppAssetsSvg.dashboardContactsCallIcn,
                  label: AppStrings.contactDetailsPhoneLabel,
                  value: contact.phone,
                ),
                if (contact.email.isNotEmpty) ...[
                  16.ph,
                  ContactInfoTile(
                    icon: AppAssetsSvg.signInMailIcn,
                    label: AppStrings.contactDetailsEmailLabel,
                    value: contact.email,
                  ),
                ],
                16.ph,
                Container(
                  width: double.infinity,
                  padding: AppInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardCardBg,
                    borderRadius: 16.circular,
                    border: Border.all(
                      color: AppColors.primaryWhite.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.contactDetailsEmergencyPermissions,
                        style: context.labelMediumStyle?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      16.ph,
                      ContactPermissionToggleRow(
                        label: AppStrings.contactDetailsGpsAccess,
                        value: _allowGps,
                        onChanged: (value) => _updatePermission(allowGps: value),
                      ),
                      10.ph,
                      ContactPermissionToggleRow(
                        label: AppStrings.contactDetailsAudioAccess,
                        value: _allowAudio,
                        onChanged: (value) => _updatePermission(allowAudio: value),
                      ),
                      10.ph,
                      ContactPermissionToggleRow(
                        label: AppStrings.contactDetailsVideoAccess,
                        value: _allowVideo,
                        onChanged: (value) => _updatePermission(allowVideo: value),
                      ),
                    ],
                  ),
                ),
                24.ph,
                Semantics(
                  button: true,
                  label: AppStrings.contactDetailsDeleteContact,
                  child: GestureDetector(
                    onTap: isDeleting ? null : _deleteContact,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: double.infinity,
                      padding: AppInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.dashboardSosRed.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: 16.circular,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppAssetsSvg.privacyControlsDeleteIcn,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                          16.pw,
                          Text(
                            isDeleting
                                ? 'Deleting...'
                                : AppStrings.contactDetailsDeleteContact,
                            style: context.labelMediumStyle?.copyWith(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.dashboardSosRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
