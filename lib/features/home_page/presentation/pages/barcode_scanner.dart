import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool _hasScanned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context).translate("scan_product"),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                AiBarcodeScanner(
                  extendBodyBehindAppBar: true,
                  sheetTitle: "Scan a Deshi Product",
                  hideSheetDragHandler: true,
                  hideSheetTitle: true,
                  scanWindowUpdateThreshold: 1.0,
                  onDetect: (BarcodeCapture code) {
                    if (!_hasScanned) {
                      _hasScanned = true;

                      final String barcode = code.barcodes.first.rawValue ?? "";
                      if (barcode.isNotEmpty) {
                        Navigator.pop(
                            context); // Go back to the previous screen
                        context.read<ProductCubit>().scanProduct(barcode);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
