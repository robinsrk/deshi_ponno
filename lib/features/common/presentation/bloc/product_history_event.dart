part of 'product_history_bloc.dart';

class LoadProductHistoryEvent extends ProductHistoryEvent {}

abstract class ProductHistoryEvent extends Equatable {
  const ProductHistoryEvent();

  @override
  List<Object> get props => [];
}

class StoreProductEvent extends ProductHistoryEvent {
  final CommonProduct product;

  const StoreProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
