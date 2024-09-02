import 'package:deshi_ponno/features/home_page/domain/entities/product.dart';

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  ProductLoaded(this.product);
}

class ProductLoading extends ProductState {}

abstract class ProductState {}
