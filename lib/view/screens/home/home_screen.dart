import 'package:bluetooth_invoices_printer/core/app_routes/app_routes.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_button/custom_button.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_text/custom_text.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/controller/home_controller.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Bluetooth Invoices Printer',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: AppSize.padding,
        child: Column(
          children: [
            Column(
              spacing: 10.h,
              children: List.generate(homeController.productsList.length, (
                index,
              ) {
                final product = homeController.productsList[index];
                return Item(
                  title: product['title'],
                  price: (product['price'] as num).toDouble(),
                  quantity: (product['price'] as num).toInt(),
                );
              }),
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        children: [
          Expanded(
            child: CustomText(
              text: 'Total: \$${homeController.total}',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.printerScreen);
              },
              title: 'Print',
            ),
          ),
        ],
      ),
    );
  }
}
