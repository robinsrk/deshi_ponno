// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final String imageUrl;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//   });
// }
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String image_url;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.image_url,
  });

  @override
  List<Object> get props => [id, name, brand];
}
