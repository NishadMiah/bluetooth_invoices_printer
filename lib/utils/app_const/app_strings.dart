class AppStrings {
  // App
  static const String appTitle = 'Bluetooth Invoice Printer';

  // Home Screen
  static const String homeTitle = 'Invoice';
  static const String addProduct = 'Add Product';
  static const String printInvoice = 'Print Invoice';
  static const String previewInvoice = 'Preview';
  static const String emptyInvoice = 'No products added yet';
  static const String emptyInvoiceSubtitle = 'Tap + to add your first product';

  // Invoice Summary
  static const String subtotal = 'Subtotal';
  static const String tax = 'Tax';
  static const String discount = 'Discount';
  static const String total = 'Total';
  static const String invoiceNumber = 'Invoice #';
  static const String date = 'Date';

  // Product Dialog
  static const String addNewProduct = 'Add New Product';
  static const String editProduct = 'Edit Product';
  static const String productName = 'Product Name';
  static const String productNameHint = 'Enter product name';
  static const String productPrice = 'Price';
  static const String productPriceHint = 'Enter price';
  static const String productQuantity = 'Quantity';
  static const String productQuantityHint = 'Enter quantity';
  static const String save = 'Save';
  static const String cancel = 'Cancel';

  // Printer Screen
  static const String selectPrinter = 'Select Printer';
  static const String scanning = 'Scanning for devices...';
  static const String noDevices = 'No bluetooth devices found';
  static const String noDevicesSubtitle = 'Make sure your printer is turned on';
  static const String refreshScan = 'Refresh';
  static const String connecting = 'Connecting...';
  static const String connected = 'Connected';
  static const String disconnected = 'Disconnected';

  // Receipt Preview
  static const String receiptPreview = 'Receipt Preview';
  static const String print = 'Print';

  // Permissions
  static const String permissionRequired = 'Permission Required';
  static const String bluetoothPermissionMessage =
      'Bluetooth permission is required to scan and connect to printers.';
  static const String locationPermissionMessage =
      'Location permission is required to scan for nearby bluetooth devices.';
  static const String openSettings = 'Open Settings';
  static const String grantPermission = 'Grant Permission';

  // Error Messages
  static const String connectionFailed = 'Failed to connect to printer';
  static const String printFailed = 'Failed to print invoice';
  static const String bluetoothDisabled = 'Bluetooth is disabled';
  static const String enableBluetooth = 'Please enable bluetooth to continue';
  static const String invalidProduct =
      'Please fill all product fields correctly';
  static const String noProductsToPrint = 'Add at least one product to print';

  // Success Messages
  static const String productAdded = 'Product added successfully';
  static const String productUpdated = 'Product updated successfully';
  static const String productDeleted = 'Product deleted successfully';
  static const String printSuccess = 'Invoice printed successfully';

  // Confirmation
  static const String deleteProduct = 'Delete Product';
  static const String deleteProductMessage =
      'Are you sure you want to delete this product?';
  static const String delete = 'Delete';
  static const String yes = 'Yes';
  static const String no = 'No';
}
