import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.brand,
  });

  factory ProductModel.fromMap(String id, Map<dynamic, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'],
      brand: data['brand'] ?? "Unknown brand",
    );
  }

  // Converts ProductModel to Product entity
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      brand: brand,
    );
  }
}
