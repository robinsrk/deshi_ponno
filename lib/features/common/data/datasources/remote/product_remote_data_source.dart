import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class CommonProductRemoteDataSource {
  Future<void> deleteScannedProduct(num id);
  Future<List<CommonProduct>> getScannedProducts();
  Future<void> storeScannedProduct(CommonProduct product);
}

class CommonProductRemoteDataSourceImpl
    implements CommonProductRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Future<void> deleteScannedProduct(num id) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DatabaseReference userProductsRef =
          _database.child('users').child(user.uid).child('history');

      final DatabaseEvent event = await userProductsRef.once();
      final DataSnapshot snapshot = event.snapshot;
      final Map<dynamic, dynamic>? scannedProducts =
          snapshot.value as Map<dynamic, dynamic>?;

      if (scannedProducts != null) {
        for (var entry in scannedProducts.entries) {
          if (entry.value['id'] == id) {
            await userProductsRef.child(entry.key).remove();
            break;
          }
        }
      }
    }
  }

  @override
  Future<List<CommonProduct>> getScannedProducts() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    final DatabaseEvent event =
        await _database.child('users').child(user.uid).child('history').once();

    final dynamic data = event.snapshot.value;

    if (data == null || data is! Map) {
      return [];
    }

    final Map<String, dynamic> productsMap = Map<String, dynamic>.from(data);

    final List<CommonProduct> products = productsMap.values
        .map((productData) {
          if (productData is Map) {
            return CommonProduct.fromMap(
                Map<String, dynamic>.from(productData));
          } else {
            print("Unexpected data format: $productData");
            return null;
          }
        })
        .whereType<CommonProduct>()
        .toList();

    return products;
  }

  @override
  Future<void> storeScannedProduct(CommonProduct product) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DatabaseReference userProductsRef =
          _database.child('users').child(user.uid).child('history');

      final DatabaseEvent event = await userProductsRef.once();
      final DataSnapshot snapshot = event.snapshot;
      final Map<dynamic, dynamic>? scannedProducts =
          snapshot.value as Map<dynamic, dynamic>?;

      bool productExists = false;
      if (scannedProducts != null) {
        for (var entry in scannedProducts.entries) {
          if (entry.value['id'] == product.id) {
            productExists = true;
            break;
          }
        }
      }

      if (!productExists) {
        await userProductsRef.push().set(product.toMap());
      }
    }
  }
}
