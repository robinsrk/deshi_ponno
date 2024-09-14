import 'package:deshi_ponno/features/all_products/domain/repositories/all_product_repository.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';

class GetAllProducts {
  final AllProductsRepository repository;

  GetAllProducts(this.repository);

  Stream<List<CommonProduct>> call() {
    return repository.getAllProducts();
  }
}
