import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_card/custom_card.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceCard extends StatelessWidget {
  final BluetoothDevice device;
  final VoidCallback onTap;
  final bool isConnecting;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onTap,
    this.isConnecting = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: isConnecting ? null : onTap,
      child: Row(
        children: [
          // Printer Icon
          Container(
            width: 56.w,
            height: 56.h,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.print,
              color: AppColors.white,
              size: AppSize.iconLarge,
            ),
          ),
          SizedBox(width: 16.w),

          // Device Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name ?? 'Unknown Device',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  device.address ?? 'N/A',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Arrow Icon or Loading
          if (isConnecting)
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          else
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textTertiary,
              size: 16.w,
            ),
        ],
      ),
    );
  }
}
