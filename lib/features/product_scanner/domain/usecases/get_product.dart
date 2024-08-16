import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
import 'package:deshi_ponno/features/product_scanner/domain/repositories/product_repository.dart';

class GetProduct implements UseCase<Product, String> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(String barcode) async {
    return await repository.getProduct(barcode);
  }
}
