import 'package:deshi_ponno/features/common/data/datasources/remote/product_remote_data_source.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/domain/repositories/product_repository.dart';

class CommonProductRepositoryImpl implements ProductRepository {
  final CommonProductRemoteDataSource remoteDataSource;

  CommonProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> deleteScannedProduct(num id) async {
    return await remoteDataSource.deleteScannedProduct(id);
  }

  @override
  Future<List<CommonProduct>> getScannedProducts() async {
    return await remoteDataSource.getScannedProducts();
  }

  @override
  Future<void> storeScannedProduct(CommonProduct product) async {
    return await remoteDataSource.storeScannedProduct(product);
  }
}
