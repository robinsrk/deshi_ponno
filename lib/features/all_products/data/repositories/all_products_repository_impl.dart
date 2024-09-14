// import 'package:deshi_ponno/features/all_products/data/datasources/remote/product_remote_data_source.dart';
// import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
// import 'package:deshi_ponno/features/all_products/domain/repositories/all_product_repository.dart';
//
// class ProductRepositoryImpl implements ProductRepository {
//   final ProductRemoteDataSource remoteDataSource;
//
//   ProductRepositoryImpl(this.remoteDataSource);
//
//   @override
//   Future<List<Product>> getAllProducts() async {
//     return await remoteDataSource.fetchAllProducts();
//   }
// }

import 'package:deshi_ponno/features/all_products/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/all_products/domain/repositories/all_product_repository.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';

class ProductListRepositoryImpl implements AllProductsRepository {
  final ProductListRemoteDataSource remoteDataSource;

  ProductListRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<CommonProduct>> getAllProducts() {
    return remoteDataSource
        .getAllProductsStream(); // Return the stream directly
  }
}
