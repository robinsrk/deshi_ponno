import 'package:deshi_ponno/features/common/domain/entities/product.dart';
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

  ProductHistoryBloc({
    required this.getScannedProducts,
    required this.storeScannedProduct,
  }) : super(ProductHistoryInitial()) {
    on<LoadProductHistoryEvent>(_onLoadProductHistory);
    on<StoreProductEvent>(_onStoreProduct);
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
