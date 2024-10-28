import 'package:deshi_ponno/features/all_products/data/models/product_model.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductListRemoteDataSource {
  final FirebaseDatabase database;

  ProductListRemoteDataSource(this.database);
  Stream<List<CommonProduct>> getAllProductsStream() {
    final DatabaseReference ref = database.ref().child('products');

    return ref.onValue.map<List<CommonProduct>>((event) {
      final snapshot = event.snapshot;
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) {
        return <CommonProduct>[];
      }

      return data.entries.map((entry) {
        final productModel = ProductModel.fromMap(entry.key, entry.value);
        return productModel.toEntity(); // Convert ProductModel to Product
      }).toList();
    });
  }
}
