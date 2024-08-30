import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:deshi_ponno/features/all_products/domain/repositories/all_product_repository.dart';

class GetAllProducts {
  final AllProductsRepository repository;

  GetAllProducts(this.repository);

  Stream<List<Product>> call() {
    return repository.getAllProducts();
  }
}
