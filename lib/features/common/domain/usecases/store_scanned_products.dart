import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/domain/repositories/product_repository.dart';

class StoreScannedProduct {
  final ProductRepository repository;

  StoreScannedProduct(this.repository);

  Future<void> call(CommonProduct product) async {
    return await repository.storeScannedProduct(product);
  }
}
