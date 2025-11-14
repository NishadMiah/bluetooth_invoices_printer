import 'package:bluetooth_invoices_printer/view/screens/home/controller/home_controller.dart';
import 'package:bluetooth_invoices_printer/view/screens/printer/controller/printer_controller.dart';
import 'package:get/get.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => PrinterController(), fenix: true);
  }
}
