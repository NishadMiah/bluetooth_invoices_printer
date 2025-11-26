import 'dart:ui';
import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingOverlay extends StatelessWidget {
  final String? message;
  final bool show;

  const LoadingOverlay({super.key, this.message, this.show = true});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                if (message != null) ...[
                  SizedBox(height: 16.h),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
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
