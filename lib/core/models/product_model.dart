class ProductModel {
  final String id;
  final String title;
  final double price;
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  // Calculate total for this product
  double get total => price * quantity;

  // Validation
  bool get isValid => title.isNotEmpty && price > 0 && quantity > 0;

  // Create a copy with updated fields
  ProductModel copyWith({
    String? id,
    String? title,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'price': price, 'quantity': quantity};
  }

  // Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, quantity: $quantity)';
  }
}
