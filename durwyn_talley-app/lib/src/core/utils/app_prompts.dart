// ignore_for_file: strict_top_level_inference

import 'package:durwyn_talley/src/components/toast_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'app_exports.dart';

class Prompts {
  static Future<void> noInternetDialog() async {
    ScaffoldMessenger.of(AppRouterGo.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        // backgroundColor: pinchToastColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Padding(
          padding: AppInsets.symmetric(vertical: 5),
          child: Text(
            "No Internet Connection",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.primaryWhite,
              fontSize: 12.sp,
            ),
          ),
        ),
        action: SnackBarAction(
          label: "Close",
          textColor: AppColors.primaryWhite,
          onPressed: () {
            ScaffoldMessenger.of(AppRouterGo.context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void showSnackBar(String message, {Duration? duration, Color? color}) {
    final context = AppRouterGo.context;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: AppInsets.only(left: 16, right: 16, bottom: 24),
        padding: EdgeInsets.zero,
        duration: duration ?? const Duration(seconds: 4),
        content: ThemeSnackBarCard(
          message: message,
          color: color,
          onDismiss: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showMaterialBanner(
    String message, {
    Duration? duration,
    Color? color,
    bool isSuccess = true,
  }) {
    final context = AppRouterGo.context;

    // Clear any existing MaterialBanner
    ScaffoldMessenger.of(context).clearMaterialBanners();

    // Show the MaterialBanner
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(
          message,
          style: context.bodyMediumStyle?.copyWith(
            color: AppColors.primaryWhite,
          ),
        ),
        backgroundColor:
            color ?? (isSuccess ? AppColors.primaryGreen : AppColors.eventRed),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text(
              'Dismiss',
              style: context.bodyMediumStyle?.copyWith(
                color: AppColors.primaryWhite,
              ),
            ),
          ),
        ],
        onVisible: () {
          Future.delayed(const Duration(seconds: 5), () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            }
          });
        },
        elevation: 6,
        padding: AppInsets.only(left: 8),
        margin: AppInsets.all(8),
      ),
    );
  }

  static void popMessenger(String message, {Duration? duration}) {
    ScaffoldMessenger.of(AppRouterGo.context).clearSnackBars();
    ScaffoldMessenger.of(AppRouterGo.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        showCloseIcon: true,
        content: Padding(
          padding: AppInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryText,
                  border: Border.all(color: AppColors.primaryText),
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.primaryWhite,
                  size: 16.sp,
                ),
              ),
              10.pw,
              Text(
                message.contains('Exception:')
                    ? message.replaceAll('Exception: ', '')
                    : message,
                style: AppTextTheme.titleMediumBlack14,
              ),
            ],
          ),
        ),
        duration: duration ?? const Duration(seconds: 5),
      ),
    );
  }

  static void showPermissionSnackBar(String message, VoidCallback onTap) {
    ScaffoldMessenger.of(AppRouterGo.context).clearSnackBars();
    ScaffoldMessenger.of(AppRouterGo.context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        // backgroundColor: pinchToastColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Padding(
          padding: AppInsets.symmetric(vertical: 5),
          child: Text(
            message,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: AppColors.primaryWhite,
              fontSize: 12.sp,
            ),
          ),
        ),
        action: SnackBarAction(
          label: "Go",
          textColor: AppColors.primaryWhite,
          onPressed: () {
            onTap();
            ScaffoldMessenger.of(AppRouterGo.context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 6),
      ),
    );
  }

  static Future<dynamic> showLogoutAlert(
    context, {
    required String title,
    VoidCallback? onLogout,
    content,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoTheme(
        data: const CupertinoThemeData(brightness: Brightness.light),
        child: CupertinoAlertDialog(
          title: Padding(
            padding: AppInsets.only(bottom: 12.0),
            child: Text(
              title,
              style: AppTextTheme.titleMediumBlue16?.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          content: Text(
            content,
            style: AppTextTheme.titleMediumBlack14?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "Cancel",
                style: AppTextTheme.titleMediumBlack16?.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              onPressed: onLogout,
              child: Text(
                "Logout",
                style: AppTextTheme.titleMediumBlack16?.copyWith(
                  color: AppColors.eventRed,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> showDeleteAccountAlert(
    context, {
    required String title,
    required TextEditingController controller,
    VoidCallback? onSubmit,
    onTapSuffix,
    required bool isObscure,
    content,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Padding(
          padding: AppInsets.only(bottom: 12.0),
          child: Text(
            title,
            style: AppTextTheme.titleMediumBlue16?.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        content: Column(
          children: [
            Text(
              content,
              style: AppTextTheme.titleMediumBlack14?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            10.ph,
            CupertinoTextField(
              controller: controller,
              obscureText: isObscure,
              placeholder: AppStrings.password,
              suffix: CupertinoButton(
                onPressed: onTapSuffix,
                child: Icon(
                  !isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primaryGrey,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              "Cancel",
              style: AppTextTheme.titleMediumBlack16?.copyWith(
                color: theme.primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            onPressed: onSubmit,
            child: Text(
              "Confirm",
              style: AppTextTheme.titleMediumBlack16?.copyWith(
                color: AppColors.primaryText,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showBottomSheet(
    BuildContext context,
    Widget Function(BuildContext) builder,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      useSafeArea: true,
      backgroundColor: AppColors.primaryWhite,
      context: context,
      builder: builder,
    );
  }

  static void showToast(
    String message, {
    bool isSuccess = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Use navigatorKey to get the overlay of the root navigator
    final overlayState =
        AppRouterGo.appRouter.routerDelegate.navigatorKey.currentState?.overlay;

    if (overlayState == null) return;

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastOverlay(
        message: message,
        isSuccess: isSuccess,
        duration: duration,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }
}

class ThemeSnackBarCard extends StatelessWidget {
  final String message;
  final Color? color;
  final VoidCallback onDismiss;

  const ThemeSnackBarCard({
    super.key,
    required this.message,
    this.color,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    // Detect whether error, success, or info
    final bool isError = color == AppColors.eventRed ||
        color == AppColors.carnation ||
        color == AppColors.fieryRed ||
        (color != null && color == const Color(0xFFD74C47));
    final bool isSuccess = color == AppColors.primaryGreen ||
        color == AppColors.successGreen ||
        color == AppColors.emeraldGreen ||
        color == AppColors.green500;

    final Color accentColor = isError
        ? const Color(0xFFEF4444)
        : isSuccess
            ? const Color(0xFF22C55E)
            : (color ?? const Color(0xFF3B82F6));

    final IconData icon = isError
        ? Icons.error_outline_rounded
        : isSuccess
            ? Icons.check_circle_outline_rounded
            : Icons.info_outline_rounded;

    return Container(
      padding: AppInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF161A22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.65),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34.w,
            height: 34.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 20.sp,
            ),
          ),
          12.pw,
          Expanded(
            child: Text(
              message.contains('Exception:')
                  ? message.replaceAll('Exception: ', '').trim()
                  : message,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryWhite,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
          8.pw,
          GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: AppInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryWhite.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: AppColors.coolGray,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

