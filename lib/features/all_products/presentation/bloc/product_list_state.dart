part of 'product_list_cubit.dart';

class ProductListError extends ProductListState {
  final String message;

  const ProductListError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductListInitial extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<CommonProduct> products;

  const ProductListLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductListLoading extends ProductListState {}

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}
