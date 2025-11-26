import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_size/app_size.dart';
import '../custom_text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width = double.maxFinite,
    required this.onTap,
    this.title = '',
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.fillColor,
    this.textColor,
    this.isBorder = false,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.useGradient = false,
    this.gradient,
    this.isLoading = false,
    this.icon,
    this.withShadow = true,
  });

  final double? height;
  final double? width;
  final Color? fillColor;
  final Color? textColor;
  final VoidCallback onTap;
  final String title;
  final double marginVertical;
  final double marginHorizontal;
  final bool isBorder;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final bool useGradient;
  final LinearGradient? gradient;
  final bool isLoading;
  final IconData? icon;
  final bool withShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 0.h),
        margin: EdgeInsets.symmetric(
          vertical: marginVertical,
          horizontal: marginHorizontal,
        ),
        alignment: Alignment.center,
        height: height ?? AppSize.buttonHeight,
        width: width,
        decoration: BoxDecoration(
          border: isBorder
              ? Border.all(
                  color: AppColors.textSecondary,
                  width: borderWidth ?? 1,
                )
              : null,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSize.radiusRound,
          ),
          color: useGradient ? null : (fillColor ?? AppColors.primary),
          gradient: useGradient
              ? (gradient ?? AppColors.primaryGradient)
              : null,
          boxShadow: withShadow && !isLoading ? AppColors.buttonShadow : null,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppColors.textOnPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: textColor ?? AppColors.textOnPrimary,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  CustomText(
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? AppColors.textOnPrimary,
                    textAlign: TextAlign.center,
                    text: title,
                  ),
                ],
              ),
      ),
    );
  }
}
