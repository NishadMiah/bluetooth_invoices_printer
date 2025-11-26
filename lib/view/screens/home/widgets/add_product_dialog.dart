import 'package:bluetooth_invoices_printer/core/models/product_model.dart';
import 'package:bluetooth_invoices_printer/utils/app_colors/app_colors.dart';
import 'package:bluetooth_invoices_printer/utils/app_size/app_size.dart';
import 'package:bluetooth_invoices_printer/utils/app_const/app_strings.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_text_field/custom_text_field.dart';
import 'package:bluetooth_invoices_printer/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductDialog extends StatefulWidget {
  final ProductModel? product; // Null for add, non-null for edit
  final Function(ProductModel) onSave;

  const AddProductDialog({super.key, this.product, required this.onSave});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    _quantityController = TextEditingController(
      text: widget.product?.quantity.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        id:
            widget.product?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );
      widget.onSave(product);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.radiusLarge),
      ),
      child: Container(
        padding: AppSize.paddingAll,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSize.radiusLarge),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.product == null
                    ? AppStrings.addNewProduct
                    : AppStrings.editProduct,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppSize.spaceLarge),
              CustomTextField(
                label: AppStrings.productName,
                hint: AppStrings.productNameHint,
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.spaceMedium),
              CustomTextField(
                label: AppStrings.productPrice,
                hint: AppStrings.productPriceHint,
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Please enter valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.spaceMedium),
              CustomTextField(
                label: AppStrings.productQuantity,
                hint: AppStrings.productQuantityHint,
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  final qty = int.tryParse(value);
                  if (qty == null || qty <= 0) {
                    return 'Please enter valid quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSize.spaceLarge),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: AppStrings.cancel,
                      onTap: () => Get.back(),
                      fillColor: AppColors.grey200,
                      textColor: AppColors.textPrimary,
                      withShadow: false,
                    ),
                  ),
                  SizedBox(width: AppSize.spaceMedium),
                  Expanded(
                    child: CustomButton(
                      title: AppStrings.save,
                      onTap: _handleSave,
                      useGradient: true,
                      icon: Icons.check,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
