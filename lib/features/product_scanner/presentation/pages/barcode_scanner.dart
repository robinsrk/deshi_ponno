import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Scan a Deshi Product",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                AiBarcodeScanner(
                  extendBodyBehindAppBar: true,
                  sheetTitle: "Scan a Deshi Product",
                  hideGalleryButton: true,
                  hideSheetDragHandler: true,
                  hideSheetTitle: true,
                  scanWindowUpdateThreshold: 1.0,
                  onDetect: (BarcodeCapture code) {
                    // Check if a barcode has already been scanned
                    if (!_hasScanned) {
                      _hasScanned = true; // Mark as scanned

                      final String barcode = code.barcodes.first.rawValue ?? "";
                      if (barcode.isNotEmpty && mounted) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(
                              context); // Go back to the previous screen
                        });
                        context.read<ProductCubit>().scanProduct(barcode);
                      }
                    }
                  },
                ),
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     margin: const EdgeInsets.only(top: 16.0),
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 8.0, horizontal: 20.0),
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFD32F2F), // Red from the flag
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: Text(
                //       "Align the barcode within the frame",
                //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //             color: Colors.white,
                //           ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
