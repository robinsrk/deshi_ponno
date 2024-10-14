import 'package:deshi_ponno/features/common/domain/entities/product.dart';

class ProductModel extends CommonProduct {
  ProductModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.imageUrl,
    required super.price,
    required super.origin,
    required super.category,
  });

  factory ProductModel.fromMap(String id, Map<dynamic, dynamic> data) {
    return ProductModel(
      id: data['id'],
      name: data['name'],
      brand: data['brand'] ?? "Unknown brand",
      price: data['price'] ?? 0.0,
      origin: data['origin'] ?? "Unknown origin",
      imageUrl: data['image_url'] ??
          "https://i.pinimg.com/originals/aa/c5/4c/aac54cd9b837f7cf979ad61c0df09dd6.png",
      category: data['category'] ?? "Unknown category",
    );
  }

  CommonProduct toEntity() {
    return CommonProduct(
      id: id,
      name: name,
      brand: brand,
      price: price,
      origin: origin,
      imageUrl: imageUrl,
      category: category,
    );
  }
}
