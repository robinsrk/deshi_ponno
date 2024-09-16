import 'package:dartz/dartz.dart';
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/features/common/domain/entities/product.dart';
import 'package:deshi_ponno/features/home_page/domain/usecases/get_product.dart';
import 'package:deshi_ponno/features/home_page/presentation/bloc/product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProduct getProduct;

  ProductCubit(this.getProduct) : super(ProductInitial());

  Future<void> scanProduct(String barcode) async {
    emit(ProductLoading());
    final Either<Failure, CommonProduct> result = await getProduct(barcode);

    result.fold<Null>(
      (Failure failure) {
        emit(ProductError("Product not found"));
      },
      (CommonProduct product) {
        emit(ProductLoaded(product));
      },
    );
  }
}
