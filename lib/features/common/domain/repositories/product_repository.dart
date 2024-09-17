import 'package:deshi_ponno/features/common/domain/entities/product.dart';

abstract class ProductRepository {
  Future<void> deleteScannedProduct(String id);
  Future<List<CommonProduct>> getScannedProducts();
  Future<void> storeScannedProduct(CommonProduct product);
}
