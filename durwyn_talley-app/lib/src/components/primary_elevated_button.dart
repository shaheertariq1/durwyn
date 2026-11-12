import 'package:flutter/cupertino.dart';
import '../core/utils/app_exports.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool loader, enabled;
  final Color? backgroundColor, textColor, loaderColor, disableButtonTextColor;
  final double? height, loaderSize;
  final double width;
  final TextStyle? style;
  final num? radius;
  final ButtonStyle? buttonStyle;
  final IconData? trailingIcon;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  const PrimaryElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.loader = false,
    this.backgroundColor,
    this.disableButtonTextColor,
    this.textColor,
    this.height,
    this.width = double.infinity,
    this.enabled = true,
    this.style,
    this.radius,
    this.loaderColor,
    this.buttonStyle,
    this.loaderSize,
    this.trailingIcon,
    this.leadingWidget,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final themedStyle = Theme.of(context).elevatedButtonTheme.style;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Figma: light mode dims the whole button (bg + label) to 60% opacity,
    // dark mode swaps to a solid muted surface (#1F2329) with muted label
    // text (#9CA3AF) at full opacity.
    final disabledBackground =
        isDark ? AppColors.choosePlanNeutralChip : AppColors.signInLightText;
    final disabledOpacity = isDark ? 1.0 : 0.6;

    return Opacity(
      opacity: enabled ? 1.0 : disabledOpacity,
      child: SizedBox(
        width: width,
        height: isPortrait ? height ?? 56.h : 50,
        child: ElevatedButton(
          onPressed: enabled ? (loader ? null : onTap) : null,
          style: buttonStyle ??
              themedStyle?.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: radius?.circular ?? 16.circular,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  enabled
                      ? loader
                          ? loaderColor ?? AppColors.successGreen
                          : (backgroundColor ?? AppColors.successGreen)
                      : disabledBackground,
                ),
              ),
          child: loader
              ? SizedBox(
                  width: loaderSize ?? 20.h,
                  height: loaderSize ?? 20.h,
                  child: (Platform.isIOS || Platform.isMacOS)
                      ? CupertinoActivityIndicator(
                          color: textColor ?? AppColors.primaryblack,
                          radius: 10,
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 3.0,
                          color: textColor ?? AppColors.primaryblack,
                          backgroundColor: AppColors.whitesmoke,
                        ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (leadingWidget != null) ...[leadingWidget!, 16.pw],
                    Text(
                      text,
                      style: style ??
                          TextStyle(
                            fontFamily: 'Roboto',
                            color: enabled
                                ? (textColor ?? AppColors.splashScrimColor)
                                : (disableButtonTextColor ??
                                    AppColors.coolGray),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.32,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    if (trailingWidget != null) ...[8.pw, trailingWidget!],
                    if (trailingWidget == null && trailingIcon != null) ...[
                      8.pw,
                      Icon(
                        trailingIcon,
                        size: 14.sp,
                        color: enabled
                            ? (textColor ?? AppColors.primaryWhite)
                            : AppColors.primaryWhite,
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
