// import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
// import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ProductCubit extends Cubit<ProductState> {
//   final GetProduct getProduct;
//
//   ProductCubit(this.getProduct) : super(ProductInitial());
//
//   Future<void> scanProduct(String barcode) async {
//     emit(ProductLoading());
//     try {
//       final product = await getProduct(barcode);
//       emit(ProductLoaded(product));
//     } catch (e) {
//       emit(ProductError("Product not found"));
//     }
//   }
// }
//
// abstract class ProductState {}
//
// class ProductInitial extends ProductState {}
//
// class ProductLoading extends ProductState {}
//
// class ProductLoaded extends ProductState {
//   final Product product;
//
//   ProductLoaded(this.product);
// }
//
// class ProductError extends ProductState {
//   final String message;
//
//   ProductError(this.message);
// }
import 'package:deshi_ponno/features/product_scanner/domain/entities/product.dart';
import 'package:deshi_ponno/features/product_scanner/domain/usecases/get_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProduct getProduct;

  ProductCubit(this.getProduct) : super(ProductInitial());

  Future<void> scanProduct(String barcode) async {
    emit(ProductLoading());
    final result = await getProduct(barcode);

    result.fold(
      (failure) {
        // Handle the failure case
        emit(ProductError("Product not found"));
      },
      (product) {
        // Handle the success case
        emit(ProductLoaded(product));
      },
    );
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  ProductLoaded(this.product);
}

class ProductLoading extends ProductState {}

abstract class ProductState {}
