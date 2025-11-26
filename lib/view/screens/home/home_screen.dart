import 'package:bluetooth_invoices_printer/core/app_routes/app_routes.dart';
import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_const/app_strings.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_button/custom_button.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/controller/home_controller.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/widgets/add_product_dialog.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/widgets/invoice_summary_card.dart';
import 'package:bluetooth_invoices_printer/view/screens/home/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundClr,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.appTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.createNewInvoice();
              Get.snackbar(
                'New Invoice',
                'Created new invoice',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
            color: AppColors.primary,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Obx(() {
          final invoice = controller.invoice.value;

          return Column(
            children: [
              // Invoice Header
              Padding(
                padding: AppSize.padding,
                child: Container(
                  padding: AppSize.paddingAll,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSize.radiusLarge),
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.invoiceNumber,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            invoice.invoiceNumber,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.date,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            invoice.formattedDate,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSize.spaceMedium),

              // Products List
              Expanded(
                child: invoice.products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80.w,
                              color: AppColors.grey400,
                            ),
                            SizedBox(height: AppSize.spaceMedium),
                            Text(
                              AppStrings.emptyInvoice,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: AppSize.spaceSmall),
                            Text(
                              AppStrings.emptyInvoiceSubtitle,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: AppSize.padding,
                        itemCount: invoice.products.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: AppSize.spaceMedium),
                        itemBuilder: (context, index) {
                          final product = invoice.products[index];
                          return Item(
                            product: product,
                            onEdit: () {
                              Get.dialog(
                                AddProductDialog(
                                  product: product,
                                  onSave: (updatedProduct) {
                                    controller.updateProduct(
                                      product.id,
                                      updatedProduct,
                                    );
                                  },
                                ),
                              );
                            },
                            onDelete: () {
                              controller.removeProduct(product.id);
                            },
                          );
                        },
                      ),
              ),

              // Summary Card
              if (invoice.products.isNotEmpty) ...[
                Padding(
                  padding: AppSize.padding,
                  child: InvoiceSummaryCard(
                    subtotal: invoice.subtotal,
                    taxPercentage: invoice.taxPercentage,
                    taxAmount: invoice.taxAmount,
                    discountPercentage: invoice.discountPercentage,
                    discountAmount: invoice.discountAmount,
                    grandTotal: invoice.grandTotal,
                  ),
                ),
                SizedBox(height: AppSize.spaceSmall),
              ],

              // Print Button
              if (invoice.products.isNotEmpty)
                Padding(
                  padding: AppSize.padding,
                  child: CustomButton(
                    title: AppStrings.printInvoice,
                    onTap: () {
                      if (controller.validateInvoice()) {
                        Get.toNamed(AppRoutes.printerScreen);
                      }
                    },
                    useGradient: true,
                    icon: Icons.print,
                  ),
                ),

              SizedBox(height: AppSize.spaceMedium),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AddProductDialog(
              onSave: (product) {
                controller.addProduct(product);
              },
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
