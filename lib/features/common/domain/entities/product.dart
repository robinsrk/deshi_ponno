import 'package:firebase_database/firebase_database.dart';

class CommonProduct {
  final String name;
  final String brand;
  final String origin;
  final num price;
  final String imageUrl;

  CommonProduct({
    required this.name,
    required this.origin,
    required this.brand,
    required this.price,
    required this.imageUrl,
  });

  factory CommonProduct.fromMap(Map<String, dynamic> map) {
    return CommonProduct(
      name: map['name'],
      brand: map['brand'],
      origin: map['origin'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }

  factory CommonProduct.fromSnapshot(DataSnapshot snapshot) {
    final productData = snapshot.value as Map<dynamic, dynamic>;
    return CommonProduct(
      name: productData['name'] ?? "Unknown Product",
      brand: productData['brand'] ?? "Unknown Brand",
      origin: productData['origin'] ?? "Unknown Origin",
      imageUrl: productData['image_url'] ??
          "https://i.pinimg.com/originals/aa/c5/4c/aac54cd9b837f7cf979ad61c0df09dd6.png",
      price: productData['price'] ?? 0.0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'brand': brand,
      'origin': origin,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
