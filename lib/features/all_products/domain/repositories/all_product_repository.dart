import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';

abstract class AllProductsRepository {
  Future<List<Product>> getAllProducts();
}
