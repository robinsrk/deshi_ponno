part of 'product_list_cubit.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  const ProductListLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError({required this.message});

  @override
  List<Object> get props => [message];
}
