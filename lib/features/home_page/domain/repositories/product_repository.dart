import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/home_page/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(String barcode);
}
