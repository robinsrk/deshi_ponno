import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/bloc/product_bloc.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/pages/barcode_scanner.dart';
import 'package:deshi_ponno/features/product_scanner/presentation/widgets/product_details_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double svgWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/login");
          },
          child: const Text("Deshi Ponno"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/welcome.svg",
                width: svgWidth,
              ),
            ],
          ),
          BlocConsumer<ProductCubit, ProductState>(
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
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Scan a product",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              } else if (state is ProductLoading) {
                return const CircularProgressIndicator();
              } else if (state is ProductLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Your scanned products: ",
                            style: Theme.of(context).textTheme.titleMedium,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(state.product.name)
                    ],
                  ),
                );
              } else if (state is ProductError) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
          );
        },
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
