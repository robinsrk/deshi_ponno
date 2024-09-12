import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';

abstract class AllProductsRepository {
  Stream<List<Product>> getAllProducts();
  // Future<List<Product>> getAllProducts();
}
