import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String origin;
  final num price;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.origin,
  });

  @override
  List<Object> get props => [id, name, brand];
}
