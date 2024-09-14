import 'package:deshi_ponno/features/common/domain/entities/product.dart';

abstract class AllProductsRepository {
  Stream<List<CommonProduct>> getAllProducts();
  // Future<List<Product>> getAllProducts();
}
