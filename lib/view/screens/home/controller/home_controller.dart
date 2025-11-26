import 'package:bluetooth_invoices_printer/core/models/invoice_model.dart';
import 'package:bluetooth_invoices_printer/core/models/product_model.dart';
import 'package:bluetooth_invoices_printer/utils/app_const/app_strings.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  // Observable invoice model
  late Rx<InvoiceModel> invoice;

  // Tax and discount observables
  final RxDouble taxPercentage = 0.0.obs;
  final RxDouble discountPercentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeInvoice();
  }

  void _initializeInvoice() {
    // Generate invoice number
    final invoiceNumber = _generateInvoiceNumber();

    // Sample products
    final List<ProductModel> sampleProducts = [
      ProductModel(
        id: '1',
        title: 'Cadbury Dairy Milk',
        price: 15.0,
        quantity: 2,
      ),
      ProductModel(
        id: '2',
        title: 'Parle-G Gluco Biscuit',
        price: 5.0,
        quantity: 5,
      ),
      ProductModel(
        id: '3',
        title: 'Fresh Onion - 1KG',
        price: 20.5,
        quantity: 1,
      ),
      ProductModel(
        id: '4',
        title: 'Fresh Sweet Lime',
        price: 20.0,
        quantity: 5,
      ),
      ProductModel(id: '5', title: 'Maggi', price: 10.0, quantity: 5),
    ];

    invoice = InvoiceModel(
      invoiceNumber: invoiceNumber,
      date: DateTime.now(),
      products: sampleProducts,
      taxPercentage: 0.0,
      discountPercentage: 0.0,
    ).obs;

    // Sync tax and discount with invoice
    taxPercentage.value = invoice.value.taxPercentage;
    discountPercentage.value = invoice.value.discountPercentage;
  }

  // Generate invoice number
  String _generateInvoiceNumber() {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyyMMdd');
    final timeFormat = DateFormat('HHmmss');
    return 'INV-${dateFormat.format(now)}-${timeFormat.format(now)}';
  }

  // Add new product
  void addProduct(ProductModel product) {
    final updatedProducts = List<ProductModel>.from(invoice.value.products)
      ..add(product);

    invoice.value = invoice.value.copyWith(products: updatedProducts);
    invoice.refresh();

    Get.snackbar(
      AppStrings.productAdded,
      product.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Update existing product
  void updateProduct(String id, ProductModel updatedProduct) {
    final updatedProducts = invoice.value.products.map((p) {
      return p.id == id ? updatedProduct : p;
    }).toList();

    invoice.value = invoice.value.copyWith(products: updatedProducts);
    invoice.refresh();

    Get.snackbar(
      AppStrings.productUpdated,
      updatedProduct.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Remove product
  void removeProduct(String id) {
    final product = invoice.value.products.firstWhere((p) => p.id == id);
    final updatedProducts = invoice.value.products
        .where((p) => p.id != id)
        .toList();

    invoice.value = invoice.value.copyWith(products: updatedProducts);
    invoice.refresh();

    Get.snackbar(
      AppStrings.productDeleted,
      product.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Update tax percentage
  void updateTax(double percentage) {
    taxPercentage.value = percentage;
    invoice.value = invoice.value.copyWith(taxPercentage: percentage);
    invoice.refresh();
  }

  // Update discount percentage
  void updateDiscount(double percentage) {
    discountPercentage.value = percentage;
    invoice.value = invoice.value.copyWith(discountPercentage: percentage);
    invoice.refresh();
  }

  // Validate invoice before printing
  bool validateInvoice() {
    if (invoice.value.products.isEmpty) {
      Get.snackbar(
        'Error',
        AppStrings.noProductsToPrint,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return invoice.value.isValid;
  }

  // Get product by ID
  ProductModel? getProductById(String id) {
    try {
      return invoice.value.products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create new invoice
  void createNewInvoice() {
    _initializeInvoice();
  }
}
