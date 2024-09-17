import 'package:deshi_ponno/features/common/domain/repositories/product_repository.dart';

class DeleteScannedProduct {
  final ProductRepository repository;
  DeleteScannedProduct(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteScannedProduct(id);
  }
}
