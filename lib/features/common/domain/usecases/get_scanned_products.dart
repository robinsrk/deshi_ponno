import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/domain/repositories/product_repository.dart';

class GetScannedProducts {
  final ProductRepository repository;

  GetScannedProducts(this.repository);

  Future<List<CommonProduct>> call() async {
    return await repository.getScannedProducts();
  }
}
