import 'package:bluetooth_invoices_printer/view/screens/home/home_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String homeScreen = "/HomeScreen";

  static List<GetPage> routes = [
    GetPage(name: homeScreen, page: () => HomeScreen()),
  ];
}
