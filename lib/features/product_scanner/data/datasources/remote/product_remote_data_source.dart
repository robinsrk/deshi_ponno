import 'package:deshi_ponno/core/errors/exceptions.dart';
import 'package:deshi_ponno/features/product_scanner/data/models/product_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProduct(String barcode);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseDatabase database;

  ProductRemoteDataSourceImpl(this.database);

  @override
  Future<ProductModel> getProduct(String barcode) async {
    final databaseRef = database.ref();
    DataSnapshot snapshot = await databaseRef.child('products/$barcode').get();

    if (snapshot.exists) {
      return ProductModel.fromSnapshot(snapshot);
    } else {
      throw ServerException();
    }
  }
}
