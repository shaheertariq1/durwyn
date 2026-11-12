import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/routing_service/named_routes.dart';
import '../theme/app_colors.dart';
import 'app_prompts.dart';
import 'app_strings.dart';

class AppImagePicker {
  static final _picker = ImagePicker();

  static BuildContext? get _activeContext {
    try {
      final rootCtx = AppRouterGo.context;
      if (rootCtx.mounted) return rootCtx;
    } catch (_) {}
    return null;
  }

  static Future<bool> _showInAppPermissionDialog({
    required String title,
    required String message,
    String confirmLabel = 'Allow',
  }) async {
    final ctx = _activeContext;
    if (ctx == null) return false;

    final result = await showDialog<bool>(
      context: ctx,
      barrierDismissible: true,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.dashboardCardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: AppColors.primaryWhite.withValues(alpha: 0.12),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryWhite,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.coolGray,
            fontSize: 14.sp,
            height: 1.4,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 16.w, bottom: 16.h, top: 8.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                color: AppColors.coolGray,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
              foregroundColor: AppColors.primaryblack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: Text(
              confirmLabel,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  static Future<File?> fromGallery() async {
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      return xFile != null ? File(xFile.path) : null;
    } catch (e) {
      // If photo library access threw an explicit permission exception
      final allow = await _showInAppPermissionDialog(
        title: 'Photos Access',
        message: 'Please allow access to your photos to choose your profile picture.',
        confirmLabel: 'Allow',
      );
      if (allow) {
        final status = await Permission.photos.request();
        if (status.isGranted || status.isLimited) {
          final xFile = await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 80,
          );
          return xFile != null ? File(xFile.path) : null;
        } else if (status.isPermanentlyDenied) {
          final openSettings = await _showInAppPermissionDialog(
            title: 'Photos Permission Required',
            message:
                'Photo access is disabled. Would you like to open Settings to enable it?',
            confirmLabel: 'Settings',
          );
          if (openSettings) {
            await openAppSettings();
          }
        }
      }
      return null;
    }
  }

  static Future<File?> fromCamera() async {
    var status = await Permission.camera.status;

    if (!status.isGranted && !status.isLimited) {
      if (status.isPermanentlyDenied) {
        final openSettings = await _showInAppPermissionDialog(
          title: 'Camera Permission Needed',
          message:
              'Camera access is required to take a photo. Would you like to enable it in Settings?',
          confirmLabel: 'Settings',
        );
        if (openSettings) {
          await openAppSettings();
        }
        return null;
      }

      final allow = await _showInAppPermissionDialog(
        title: 'Camera Access',
        message:
            'Trouble Cheat needs camera access to capture your profile picture.',
        confirmLabel: 'Allow',
      );
      if (!allow) return null;

      status = await Permission.camera.request();
      if (!status.isGranted && !status.isLimited) {
        if (status.isPermanentlyDenied) {
          final openSettings = await _showInAppPermissionDialog(
            title: 'Camera Permission Required',
            message:
                'Camera access was denied. Would you like to open Settings to enable it?',
            confirmLabel: 'Settings',
          );
          if (openSettings) {
            await openAppSettings();
          }
        } else {
          Prompts.showToast(AppStrings.permissionDeniedMessage, isSuccess: false);
        }
        return null;
      }
    }

    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      return xFile != null ? File(xFile.path) : null;
    } catch (e) {
      Prompts.showToast('Unable to open camera: $e', isSuccess: false);
      return null;
    }
  }

  static Future<File?> videoFromGallery() async {
    try {
      final xFile = await _picker.pickVideo(source: ImageSource.gallery);
      return xFile != null ? File(xFile.path) : null;
    } catch (e) {
      Prompts.showToast('Unable to access video gallery: $e', isSuccess: false);
      return null;
    }
  }
}

// import 'dart:io';
// //import 'package:file_picker/file_picker.dart');
// //import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AppHelpers {
//   static Future<void> openUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch url $url';
//     }
//   }

//   static Future<void> openDialPad(String phoneNumber) async {
//     final uri = Uri(scheme: 'tel', path: phoneNumber);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $phoneNumber';
//     }
//   }

//   static Future<void> openEmailClient(String emailAddress) async {
//     final uri = Uri(
//       scheme: 'mailto',
//       path: emailAddress,
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch email client for $emailAddress';
//     }
//   }

//   static Future<File> pickSingleFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'docx', 'doc'],
//     );
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       return file;
//     } else {
//       throw ('Failed to pick file');
//     }
//   }

//   static final ImagePicker _picker = ImagePicker();
//   static Future<XFile?> pick() async {
//     return await _picker.pickImage(source: ImageSource.gallery);
//   }

//   static Future<XFile?> capture() async {
//     return await _picker.pickImage(source: ImageSource.camera);
//   }

//   // give time like 3 minutes/seconds ago etc
//   static String getFormattedDate(DateTime date) {
//     DateTime now = DateTime.now().toLocal();
//     DateTime newDate = date.toLocal();

//     Duration difference = now.difference(newDate);

//     int inSeconds = difference.inSeconds;
//     int inMinutes = difference.inMinutes;
//     int inHours = difference.inHours;
//     int inDays = difference.inDays;

//     if (inSeconds < 60) {
//       return "$inSeconds sec ago";
//     } else if (inMinutes < 60) {
//       return "$inMinutes min ago";
//     } else if (inHours < 24) {
//       return "$inHours hr${inHours > 1 ? 's' : ''} ago";
//     } else if (inDays == 1) {
//       return "Yesterday";
//     } else if (inDays < 7) {
//       return "$inDays days ago";
//     } else if (inDays < 30) {
//       int weeks = (inDays / 7).floor();
//       return "$weeks week${weeks > 1 ? 's' : ''} ago";
//     } else if (inDays < 365) {
//       int months = (inDays / 30).floor();
//       return "$months month${months > 1 ? 's' : ''} ago";
//     } else {
//       int years = (inDays / 365).floor();
//       return "$years year${years > 1 ? 's' : ''} ago";
//     }
//   }

//   static DateFormat formatter = DateFormat('yyyy-MM-dd');

//   static String formatDate(String? dateString) {
//     if (dateString == null || dateString.isEmpty) {
//       return 'N/A';
//     }
//     try {
//       return DateFormat('MMM dd, yyyy').format(DateTime.parse(dateString));
//     } catch (e) {
//       return 'Invalid date';
//     }
//   }

//   static String formatTime(String? dateString) {
//     if (dateString == null || dateString.isEmpty) {
//       return 'N/A';
//     }
//     try {
//       return DateFormat('h:mm a').format(DateTime.parse(dateString));
//     } catch (e) {
//       return 'Invalid time';
//     }
//   }

//   static Future<List<XFile?>?> pickMultiple() async {
//     final ImagePicker picker = ImagePicker();
//     final List<XFile?> images = await picker.pickMultiImage();
//     return images;
//   }

//   static String formatDateTime(DateTime dateTime) {
//     return DateFormat('hh:mm a').format(dateTime);
//   }

// // add method to share multiple files via share_plus package
//   static Future<void> shareMultipleFiles(List<XFile> filePaths) async {
//     try {
//       await Share.shareXFiles(filePaths);
//     } catch (e) {
//       throw Exception('Could not share files: $e');
//     }
//   }
// }
