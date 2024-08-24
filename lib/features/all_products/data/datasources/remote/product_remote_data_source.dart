// import 'package:deshi_ponno/features/product_scanner/data/models/product_model.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class ProductListRemoteDataSource {
//   final FirebaseDatabase database;
//
//   ProductListRemoteDataSource(this.database);
//
//   Future<List<ProductModel>> getAllProducts() async {
//     final ref = database.reference().child('products');
//     final snapshot = await ref.once();
//     final data = snapshot.value as Map<dynamic, dynamic>;
//
//     return data.entries.map((entry) {
//       return ProductModel.fromMap(entry.key, entry.value);
//     }).toList();
//   }
// }
import 'package:deshi_ponno/features/all_products/data/models/product_model.dart';
import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductListRemoteDataSource {
  final FirebaseDatabase database;

  ProductListRemoteDataSource(this.database);

  Future<List<Product>> getAllProducts() async {
    final ref = database.reference().child('products');
    final event = await ref.once();
    final snapshot = event.snapshot; // Correct usage
    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data == null) {
      return []; // Return an empty list if no data is found
    }

    // Convert List<ProductModel> to List<Product>
    return data.entries.map((entry) {
      final productModel = ProductModel.fromMap(entry.key, entry.value);
      return productModel.toEntity(); // Convert ProductModel to Product
    }).toList();
  }
}
