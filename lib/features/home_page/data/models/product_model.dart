import 'package:deshi_ponno/features/home_page/domain/entities/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.name,
      required super.brand,
      required super.imageUrl,
      required super.price});

  factory ProductModel.fromSnapshot(DataSnapshot snapshot) {
    final productData = snapshot.value as Map<dynamic, dynamic>;
    return ProductModel(
      name: productData['name'] ?? "Unknown Product",
      brand: productData['brand'] ?? "Unknown Brand",
      imageUrl: productData['image_url'] ??
          "https://i.pinimg.com/originals/aa/c5/4c/aac54cd9b837f7cf979ad61c0df09dd6.png",
      price: productData['price'] ?? 0.0,
    );
  }
}
