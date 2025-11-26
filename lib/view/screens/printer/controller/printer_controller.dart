import 'package:bluetooth_invoices_printer/view/screens/home/controller/home_controller.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrinterController extends GetxController {
  final RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  final HomeController homeController = Get.find<HomeController>();
  final RxString devicesMsg = 'Scanning for devices...'.obs;
  final RxBool isScanning = true.obs;
  final RxBool isConnecting = false.obs;
  final RxString connectionStatus = ''.obs;

  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final NumberFormat currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  @override
  void onInit() {
    super.onInit();
    _startScan();
  }

  Future<void> _startScan() async {
    try {
      isScanning.value = true;
      devicesMsg.value = 'Scanning for devices...';

      final List<BluetoothDevice> availableDevices = await bluetooth
          .getBondedDevices();
      devices.assignAll(availableDevices);

      isScanning.value = false;

      if (devices.isEmpty) {
        devicesMsg.value = 'No blue tooth devices found';
      } else {
        devicesMsg.value = '';
      }
    } catch (e) {
      isScanning.value = false;
      devicesMsg.value = 'Error scanning: ${e.toString()}';
    }
  }

  Future<void> refreshScan() async {
    devices.clear();
    await _startScan();
  }

  Future<void> startPrint(BluetoothDevice device) async {
    try {
      isConnecting.value = true;
      connectionStatus.value = 'Connecting...';

      // Check if already connected
      bool? isConnected = await bluetooth.isConnected;
      if (isConnected == true) {
        await bluetooth.disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // Connect to device
      await bluetooth.connect(device);

      // Verify connection
      isConnected = await bluetooth.isConnected;
      if (isConnected != true) {
        throw Exception('Failed to connect to printer');
      }

      connectionStatus.value = 'Connected';

      // Print the invoice
      await _printInvoice();

      Get.snackbar(
        'Success',
        'Invoice printed successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      // Disconnect after printing
      await Future.delayed(const Duration(seconds: 1));
      await bluetooth.disconnect();
      connectionStatus.value = 'Disconnected';
    } catch (e) {
      connectionStatus.value = 'Connection failed';
      Get.snackbar(
        'Error',
        'Failed to print: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isConnecting.value = false;
    }
  }

  Future<void> _printInvoice() async {
    final invoice = homeController.invoice.value;
    final f = currencyFormat;

    // Header
    bluetooth.printNewLine();
    bluetooth.printCustom('INVOICE', 3, 1); // Size 3, Center aligned
    bluetooth.printCustom('================================', 1, 1);
    bluetooth.printNewLine();

    // Invoice details
    bluetooth.printLeftRight('Invoice:', invoice.invoiceNumber, 1);
    bluetooth.printLeftRight('Date:', invoice.printFormattedDate, 1);
    bluetooth.printCustom('================================', 1, 1);
    bluetooth.printNewLine();

    // Products
    for (var product in invoice.products) {
      // Product name
      bluetooth.printCustom(product.title, 1, 0); // Size 1, Left aligned

      // Price x Quantity = Total
      final priceQty = '  ${f.format(product.price)} x ${product.quantity}';
      final total = '= ${f.format(product.total)}';
      bluetooth.printLeftRight(priceQty, total, 0);
    }

    bluetooth.printNewLine();
    bluetooth.printCustom('================================', 1, 1);

    // Summary
    bluetooth.printLeftRight('Subtotal:', f.format(invoice.subtotal), 1);

    if (invoice.taxPercentage > 0) {
      bluetooth.printLeftRight(
        'Tax (${invoice.taxPercentage}%):',
        f.format(invoice.taxAmount),
        1,
      );
    }

    if (invoice.discountPercentage > 0) {
      bluetooth.printLeftRight(
        'Discount (${invoice.discountPercentage}%):',
        '-${f.format(invoice.discountAmount)}',
        1,
      );
    }

    bluetooth.printCustom('================================', 1, 1);
    bluetooth.printNewLine();

    // Grand total
    bluetooth.printCustom(
      'TOTAL: ${f.format(invoice.grandTotal)}',
      2,
      1,
    ); // Size 2, Center
    bluetooth.printNewLine();
    bluetooth.printCustom('================================', 1, 1);

    // Footer
    bluetooth.printNewLine();
    bluetooth.printCustom('Thank you for your business!', 1, 1);
    bluetooth.printNewLine();
    bluetooth.printNewLine();
    bluetooth.printNewLine();

    // Cut paper (if supported)
    bluetooth.paperCut();
  }

  @override
  void onClose() {
    bluetooth.disconnect();
    super.onClose();
  }
}
