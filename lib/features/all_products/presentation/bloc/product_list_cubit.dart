import 'package:bloc/bloc.dart';
import 'package:deshi_ponno/features/all_products/domain/entities/product.dart';
import 'package:deshi_ponno/features/all_products/domain/usecases/get_all_products.dart';
import 'package:equatable/equatable.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final GetAllProducts getAllProducts;

  ProductListCubit(this.getAllProducts) : super(ProductListInitial());

  void fetchAllProducts() async {
    try {
      emit(ProductListLoading());
      final products = await getAllProducts();
      emit(ProductListLoaded(products: products));
    } catch (e) {
      emit(ProductListError(message: e.toString()));
    }
  }
}
