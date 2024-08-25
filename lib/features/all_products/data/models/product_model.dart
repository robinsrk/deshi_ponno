import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.image_url,
  });

  factory ProductModel.fromMap(String id, Map<dynamic, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'],
      brand: data['brand'] ?? "Unknown brand",
      image_url: data['image_url'] ??
          "https://i.pinimg.com/originals/aa/c5/4c/aac54cd9b837f7cf979ad61c0df09dd6.png",
    );
  }

  // Converts ProductModel to Product entity
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      brand: brand,
      image_url: image_url,
    );
  }
}
