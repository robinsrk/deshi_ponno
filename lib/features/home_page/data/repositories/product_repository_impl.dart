import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/exceptions.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/home_page/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/home_page/domain/entities/product.dart';
import 'package:deshi_ponno/features/home_page/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Product>> getProduct(String barcode) async {
    try {
      // Fetch product from remote data source
      final product = await remoteDataSource.getProduct(barcode);

      // Convert the fetched data to a Product entity
      // Assuming `product` is of type `Product` here
      return Right(product);
    } on ServerException {
      // Return a failure when a server exception occurs
      return Left(ServerFailure('Server error occurred'));
    } catch (e) {
      // Handle other potential errors and return a generic failure
      return Left(GeneralFailure('An unexpected error occurred'));
    }
  }
}
