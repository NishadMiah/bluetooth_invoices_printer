import 'package:bluetooth_invoices_printer/view/screens/printer/controller/printer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PrinterController printerController = Get.find<PrinterController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
        backgroundColor: Colors.redAccent,
      ),
      body: Obx(() {
        if (printerController.devices.isEmpty) {
          return Center(child: Text(printerController.devicesMsg.value));
        }

        return ListView.builder(
          itemCount: printerController.devices.length,
          itemBuilder: (_, i) {
            final device = printerController.devices[i];
            return ListTile(
              leading: const Icon(Icons.print),
              title: Text(device.name ?? "N/A"),
              subtitle: Text(device.address ?? "N/A"),
              onTap: () => printerController.startPrint(device),
            );
          },
        );
      }),
    );
  }
}
