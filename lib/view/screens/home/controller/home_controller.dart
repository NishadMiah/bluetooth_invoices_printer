import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _calculateTotal();
  }

  final List<Map<String, dynamic>> productsList = [
    {'title': 'Cadbury Dairy Milk', 'price': 15.0, 'qty': 2},
    {'title': 'Parle-G Gluco Biscut', 'price': 5.0, 'qty': 5},
    {'title': 'Fresh Onion - 1KG', 'price': 20.5, 'qty': 1},
    {'title': 'Fresh Sweet Lime', 'price': 20.0, 'qty': 5},
    {'title': 'Maggi', 'price': 10, 'qty': 5.0},
  ];
  final RxDouble total = 0.0.obs;
  void _calculateTotal() {
    final sum = productsList.fold<double>(
      0.0,
      (previous, product) => previous + (product['price']) * (product['qty']),
    );
    total.value = sum;
  }
}
