import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Item extends StatelessWidget {
  final String? title;
  final int? quantity;
  final double? price;
  const Item({super.key, this.title, this.quantity, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title ?? 'Unknown',
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              CustomText(
                text: '\$${price ?? 0} *  ${quantity ?? 0}',
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                fontSize: 16.sp,
              ),
            ],
          ),
          CustomText(
            text: '\$${(price ?? 0) * (quantity ?? 0)}',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
