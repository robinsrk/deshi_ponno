import 'package:deshi_ponno/features/common/domain/entities/product.dart';

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final CommonProduct product;

  ProductLoaded(this.product);
}

class ProductLoading extends ProductState {}

abstract class ProductState {}
