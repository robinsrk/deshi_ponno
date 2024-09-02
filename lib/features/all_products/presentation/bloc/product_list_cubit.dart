import 'dart:async';

import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:deshi_ponno/features/all_products/domain/usecases/get_all_products.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final GetAllProducts getAllProducts;
  late StreamSubscription<List<Product>> _productsSubscription;

  ProductListCubit(this.getAllProducts) : super(ProductListInitial()) {
    _productsSubscription = getAllProducts().listen(
      (products) {
        emit(ProductListLoaded(products: products));
      },
      onError: (error) {
        emit(ProductListError(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _productsSubscription.cancel();
    return super.close();
  }
}
