import 'dart:developer' as dev;

import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/common/domain/usecases/delete_scanned_product.dart';
import 'package:deshi_ponno/features/common/domain/usecases/get_scanned_products.dart';
import 'package:deshi_ponno/features/common/domain/usecases/store_scanned_products.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_history_event.dart';
part 'product_history_state.dart';

class ProductHistoryBloc
    extends Bloc<ProductHistoryEvent, ProductHistoryState> {
  final GetScannedProducts getScannedProducts;
  final StoreScannedProduct storeScannedProduct;
  final DeleteScannedProduct deleteScannedProduct;

  ProductHistoryBloc({
    required this.getScannedProducts,
    required this.storeScannedProduct,
    required this.deleteScannedProduct,
  }) : super(ProductHistoryInitial()) {
    on<LoadProductHistoryEvent>(_onLoadProductHistory);
    on<StoreProductEvent>(_onStoreProduct);
  }

  Future<void> deleteProduct(num productId) async {
    emit(ProductHistoryLoading());
    try {
      await deleteScannedProduct(productId);
      // Update the list of products after deletion
      final products = await getScannedProducts();
      emit(ProductHistoryLoaded(products));
    } catch (e) {
      emit(const ProductHistoryError("Failed to delete the product."));
    }
  }

  Future<void> _onLoadProductHistory(
      LoadProductHistoryEvent event, Emitter<ProductHistoryState> emit) async {
    emit(ProductHistoryLoading());
    try {
      final products = await getScannedProducts();
      if (products.isNotEmpty) {
        emit(ProductHistoryLoaded(products));
      } else {
        emit(ProductHistoryEmpty());
      }
    } catch (e) {
      emit(const ProductHistoryError("Could not load product history"));
      dev.log("product history error: $e");
    }
  }

  Future<void> _onStoreProduct(
      StoreProductEvent event, Emitter<ProductHistoryState> emit) async {
    try {
      await storeScannedProduct(event.product);
      add(LoadProductHistoryEvent());
    } catch (e) {
      emit(const ProductHistoryError("Could not store product"));
    }
  }
}
