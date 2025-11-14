import 'package:bluetooth_invoices_printer/view/screens/home/home_screen.dart';
import 'package:bluetooth_invoices_printer/view/screens/printer/printer_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String homeScreen = "/homeScreen";
  static const String printerScreen = "/printerScreen";

  static List<GetPage> routes = [
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: printerScreen, page: () => PrinterScreen()),
  ];
}
