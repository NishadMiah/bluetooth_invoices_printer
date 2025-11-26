import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_const/app_strings.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/view/screens/printer/controller/printer_controller.dart';
import 'package:bluetooth_invoices_printer/view/screens/printer/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrinterController controller = Get.find<PrinterController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundClr,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: AppColors.textPrimary,
        ),
        title: Text(
          AppStrings.selectPrinter,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Obx(() {
          // Show loading state while scanning
          if (controller.isScanning.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.spaceLarge),
                  Text(
                    AppStrings.scanning,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSize.spaceSmall),
                  Text(
                    'Make sure your printer is turned on',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Show empty state if no devices found
          if (controller.devices.isEmpty) {
            return Center(
              child: Padding(
                padding: AppSize.padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bluetooth_disabled,
                      size: 80.w,
                      color: AppColors.grey400,
                    ),
                    SizedBox(height: AppSize.spaceLarge),
                    Text(
                      AppStrings.noDevices,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSize.spaceSmall),
                    Text(
                      AppStrings.noDevicesSubtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppSize.spaceLarge),
                    ElevatedButton.icon(
                      onPressed: controller.refreshScan,
                      icon: const Icon(Icons.refresh),
                      label: Text(AppStrings.refreshScan),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSize.radiusRound,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Show device list
          return Column(
            children: [
              // Connection status banner
              if (controller.connectionStatus.value.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: controller.connectionStatus.value == 'Connected'
                        ? AppColors.success
                        : controller.connectionStatus.value == 'Connecting...'
                        ? AppColors.info
                        : AppColors.error,
                  ),
                  child: Text(
                    controller.connectionStatus.value,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Device list
              Expanded(
                child: ListView.separated(
                  padding: AppSize.paddingAll,
                  itemCount: controller.devices.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: AppSize.spaceMedium),
                  itemBuilder: (context, index) {
                    final device = controller.devices[index];
                    return DeviceCard(
                      device: device,
                      onTap: () => controller.startPrint(device),
                      isConnecting: controller.isConnecting.value,
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Obx(() {
        if (controller.isScanning.value) return const SizedBox.shrink();

        return FloatingActionButton(
          onPressed: controller.refreshScan,
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.refresh, color: AppColors.white),
        );
      }),
    );
  }
}
