import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/utils/app_const/app_strings.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_card/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class InvoiceSummaryCard extends StatelessWidget {
  final double subtotal;
  final double taxPercentage;
  final double taxAmount;
  final double discountPercentage;
  final double discountAmount;
  final double grandTotal;

  const InvoiceSummaryCard({
    super.key,
    required this.subtotal,
    required this.taxPercentage,
    required this.taxAmount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return CustomCard(
      useGradient: true,
      gradientColors: const [Color(0xffF8FAFC), Color(0xffFFFFFF)],
      child: Column(
        children: [
          _buildSummaryRow(AppStrings.subtotal, f.format(subtotal), false),
          SizedBox(height: AppSize.spaceSmall),
          _buildSummaryRow(
            '${AppStrings.tax} ($taxPercentage%)',
            f.format(taxAmount),
            false,
          ),
          SizedBox(height: AppSize.spaceSmall),
          _buildSummaryRow(
            '${AppStrings.discount} ($discountPercentage%)',
            '- ${f.format(discountAmount)}',
            false,
            color: AppColors.error,
          ),
          Divider(
            height: AppSize.spaceLarge,
            thickness: 2,
            color: AppColors.grey300,
          ),
          _buildSummaryRow(AppStrings.total, f.format(grandTotal), true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    bool isBold, {
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 18.sp : 14.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: color ?? AppColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 20.sp : 16.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color:
                color ?? (isBold ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
