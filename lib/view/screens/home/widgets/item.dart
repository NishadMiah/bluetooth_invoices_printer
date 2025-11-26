import 'package:bluetooth_invoices_printer/core/models/product_model.dart';
import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_card/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Item extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const Item({super.key, required this.product, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Dismissible(
      key: Key(product.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        if (onDelete == null) return false;
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.radiusLarge),
              ),
              title: const Text('Delete Product'),
              content: Text(
                'Are you sure you want to delete "${product.title}"?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        if (onDelete != null) onDelete!();
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppSize.radiusLarge),
        ),
        child: Icon(
          Icons.delete,
          color: AppColors.white,
          size: AppSize.iconLarge,
        ),
      ),
      child: CustomCard(
        onTap: onEdit,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Product icon
            Container(
              width: 48.w,
              height: 48.h,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag,
                color: AppColors.white,
                size: 24.w,
              ),
            ),
            SizedBox(width: 12.w),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${f.format(product.price)} × ${product.quantity}', // FIXED: Now correctly shows quantity
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Total price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  f.format(product.total),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Icon(Icons.edit, size: 16.w, color: AppColors.textTertiary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
