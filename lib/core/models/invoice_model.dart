import 'package:bluetooth_invoices_printer/core/models/product_model.dart';
import 'package:intl/intl.dart';

class InvoiceModel {
  final String invoiceNumber;
  final DateTime date;
  final List<ProductModel> products;
  final double taxPercentage; // e.g., 10 for 10%
  final double discountPercentage; // e.g., 5 for 5%

  InvoiceModel({
    required this.invoiceNumber,
    required this.date,
    required this.products,
    this.taxPercentage = 0.0,
    this.discountPercentage = 0.0,
  });

  // Calculate subtotal (sum of all product totals)
  double get subtotal {
    return products.fold<double>(0.0, (sum, product) => sum + product.total);
  }

  // Calculate tax amount
  double get taxAmount => subtotal * (taxPercentage / 100);

  // Calculate discount amount
  double get discountAmount => subtotal * (discountPercentage / 100);

  // Calculate grand total
  double get grandTotal => subtotal + taxAmount - discountAmount;

  // Format date for display
  String get formattedDate => DateFormat('MMM dd, yyyy').format(date);

  // Format date for printing
  String get printFormattedDate => DateFormat('dd/MM/yyyy').format(date);

  // Validation
  bool get isValid => products.isNotEmpty && products.every((p) => p.isValid);

  // Create a copy with updated fields
  InvoiceModel copyWith({
    String? invoiceNumber,
    DateTime? date,
    List<ProductModel>? products,
    double? taxPercentage,
    double? discountPercentage,
  }) {
    return InvoiceModel(
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
      products: products ?? this.products,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'invoiceNumber': invoiceNumber,
      'date': date.toIso8601String(),
      'products': products.map((p) => p.toJson()).toList(),
      'taxPercentage': taxPercentage,
      'discountPercentage': discountPercentage,
    };
  }

  // Create from JSON
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoiceNumber: json['invoiceNumber'] as String,
      date: DateTime.parse(json['date'] as String),
      products: (json['products'] as List)
          .map((p) => ProductModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      taxPercentage: (json['taxPercentage'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
