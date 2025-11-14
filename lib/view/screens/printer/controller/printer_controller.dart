import 'package:bluetooth_invoices_printer/view/screens/home/controller/home_controller.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrinterController extends GetxController {
  final RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  final HomeController homeController = Get.find<HomeController>();
  final RxString devicesMsg = ''.obs;

  final BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  final NumberFormat f = NumberFormat("\$###,###.00", "en_US");

  @override
  void onInit() {
    super.onInit();
    _startScan();
  }

  Future<void> _startScan() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 2));

    bluetoothPrint.scanResults.listen((List<BluetoothDevice> val) {
      devices.assignAll(val);

      if (devices.isEmpty) {
        devicesMsg.value = "No Devices";
      } else {
        devicesMsg.value = "";
      }
    });
  }

  Future<void> startPrint(BluetoothDevice device) async {
    if (device.address == null) return;
    final data = homeController.productsList;

    await bluetoothPrint.connect(device);

    Map<String, dynamic> config = {};
    List<LineText> lines = [];

    lines.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: "BlazeAura App Studio",
        weight: 2,
        width: 2,
        height: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
    );

    for (var item in data) {
      lines.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: item['title']?.toString() ?? '',
          weight: 0,
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
      lines.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "${f.format(item['price'])} x ${item['qty']}",
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
    }

    await bluetoothPrint.printReceipt(config, lines);
  }

  @override
  void onClose() {
    bluetoothPrint.stopScan();
    super.onClose();
  }
}
