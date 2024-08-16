import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.brand,
  });

  factory ProductModel.fromSnapshot(DataSnapshot snapshot) {
    final productData = snapshot.value as Map<dynamic, dynamic>;
    return ProductModel(
      name: productData['name'] ?? "Unknown Product",
      brand: productData['brand'] ?? "Unknown Brand",
    );
  }
}
