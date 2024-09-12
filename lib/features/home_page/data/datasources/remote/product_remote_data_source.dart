import 'package:deshi_ponno/core/errors/exceptions.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ProductRemoteDataSource {
  Future<CommonProduct> getProduct(String barcode);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseDatabase database;

  ProductRemoteDataSourceImpl(this.database);

  @override
  Future<CommonProduct> getProduct(String barcode) async {
    final databaseRef = database.ref();
    DataSnapshot snapshot = await databaseRef.child('products/$barcode').get();

    if (snapshot.exists) {
      return CommonProduct.fromSnapshot(snapshot);
    } else {
      throw ServerException();
    }
  }
}
