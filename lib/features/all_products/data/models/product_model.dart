import 'package:deshi_ponno/features/common/domain/entities/product.dart';

class ProductModel extends CommonProduct {
  ProductModel({
    required super.name,
    required super.brand,
    required super.imageUrl,
    required super.price,
    required super.origin,
  });

  factory ProductModel.fromMap(String id, Map<dynamic, dynamic> data) {
    return ProductModel(
      name: data['name'],
      brand: data['brand'] ?? "Unknown brand",
      price: data['price'] ?? 0.0,
      origin: data['origin'] ?? "Unknown origin",
      imageUrl: data['image_url'] ??
          "https://i.pinimg.com/originals/aa/c5/4c/aac54cd9b837f7cf979ad61c0df09dd6.png",
    );
  }

  CommonProduct toEntity() {
    return CommonProduct(
      name: name,
      brand: brand,
      price: price,
      origin: origin,
      imageUrl: imageUrl,
    );
  }
}
