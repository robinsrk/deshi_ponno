import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, CommonProduct>> getProduct(String barcode);
}
