import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deshi Ponno"),
      ),
      body: Center(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductLoaded) {
              _showProductDetailsBottomSheet(context, state.product);
            } else if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductInitial) {
              return const Text("Scan a product");
            } else if (state is ProductLoading) {
              return const CircularProgressIndicator();
            } else if (state is ProductLoaded) {
              return Text("Scanned product: ${state.product.name}");
            } else if (state is ProductError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String barcode = await FlutterScanner.scanBarcode(
          //   lineColor: '#ff6666',
          //   cancelButtonText: 'Exit',
          //   isShowFlashIcon: true,
          //   scanMode: ScanMode.QR,
          //   iconSize: 50,
          //   fontSize: 20,
          // );

          var res = await BarcodeScanner.scan();
          String barcode = res.rawContent;

          if (barcode.isNotEmpty) {
            context.read<ProductCubit>().scanProduct(barcode);
          }
        },
        tooltip: "Scan for product",
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  void _showProductDetailsBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ProductDetailsBottomSheet(product: product);
      },
    );
  }
}
