part of 'product_history_bloc.dart';

class ProductHistoryEmpty extends ProductHistoryState {}

class ProductHistoryError extends ProductHistoryState {
  final String message;

  const ProductHistoryError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductHistoryInitial extends ProductHistoryState {}

class ProductHistoryLoaded extends ProductHistoryState {
  final List<CommonProduct> products;

  const ProductHistoryLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductHistoryLoading extends ProductHistoryState {}

abstract class ProductHistoryState extends Equatable {
  const ProductHistoryState();

  @override
  List<Object> get props => [];
}
