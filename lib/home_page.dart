import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";
  String productName = "";
  String productBrand = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deshi Ponno"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text("Scan a product."),
            Text(productName.isNotEmpty
                ? "Scanned product: $productName"
                : "Scan a product"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var raw = await BarcodeScanner.scan(
            options: const ScanOptions(
              strings: {"title": "Scan deshi products"},
              restrictFormat: [BarcodeFormat.qr],
            ),
          );
          var res = raw.rawContent;
          if (res != "-1") {
            result = res;
            await getProduct(res);
            if (mounted) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Details",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(
                          productName.isNotEmpty
                              ? "Name: $productName"
                              : "Product not found",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          productName.isNotEmpty
                              ? "Brand: $productBrand"
                              : "Product not found",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (productName.isEmpty)
                              ElevatedButton(
                                onPressed: () {
                                  // Add your request product logic here
                                },
                                child: const Text("Request Product"),
                              ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
        tooltip: "Scan for product",
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Future<void> getProduct(String barcode) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    try {
      DataSnapshot snapshot =
          await databaseRef.child('products/$barcode').get();
      if (snapshot.exists) {
        setState(() {
          final productData = snapshot.value as Map<dynamic, dynamic>;
          productName = productData['name'] ?? "Unknown Product";
          productBrand = productData['brand'] ?? "Unknown Brand";
        });
      } else {
        setState(() {
          productName = "";
        });
      }
    } catch (e) {
      print('Error fetching product: $e');
      setState(() {
        productName = "Error fetching product";
      });
    }
  }
}
