import 'package:flutter/material.dart';
import '../../color/app_color.dart';
import '../../fonts/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final bool loading;
  final Color? buttonColor;
  final Gradient? gradient;
  final TextStyle? textStyle;
  final double borderRadius;
  final bool isFullWidth;
  final List<BoxShadow>? boxShadow;
  final bool showShadow;
  final bool iconRight;

  const CustomButton({
    super.key,
    this.title,
    this.icon,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.loading = false,
    this.buttonColor,
    this.gradient = AppColors.primaryGradient,
    this.textStyle,
    this.borderRadius = 30,
    this.isFullWidth = true,
    this.boxShadow,
    this.showShadow = true,
    this.iconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: loading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          width: isFullWidth ? (width ?? double.infinity) : width,
          height: height,
          decoration: BoxDecoration(
            color: buttonColor,
            gradient: buttonColor == null ? gradient : null,
            borderRadius: BorderRadius.circular(borderRadius),
            // Shadow sirf tabhi dikhayenge jab showShadow true ho AUR (boxShadow pass ho ya primary button ho)
            boxShadow: showShadow 
                ? (boxShadow ?? (buttonColor == null ? AppColors.primaryGlow : null))
                : null,
          ),
          child: Center(
            child: loading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null && !iconRight) ...[
                        Icon(
                          icon,
                          color: textStyle?.color ?? AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                      ],
                      if (title != null)
                        Text(
                          title!,
                          style: textStyle ?? AppFonts.button,
                        ),
                      if (icon != null && iconRight) ...[
                        const SizedBox(width: 10),
                        Icon(
                          icon,
                          color: textStyle?.color ?? AppColors.white,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
