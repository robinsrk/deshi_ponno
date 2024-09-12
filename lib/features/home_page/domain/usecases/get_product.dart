import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/home_page/domain/repositories/product_repository.dart';

class GetProduct implements UseCase<CommonProduct, String> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Either<Failure, CommonProduct>> call(String barcode) async {
    return await repository.getProduct(barcode);
  }
}
