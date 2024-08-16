import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(String barcode);
}
