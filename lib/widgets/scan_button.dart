import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:residentes/themes/appTheme.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: const Icon(Icons.filter_center_focus),
        backgroundColor: AppTheme.primary,
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#3D8BEF", "Cancelar", false, ScanMode.QR);
          print(barcodeScanRes);
        });
  }
}
