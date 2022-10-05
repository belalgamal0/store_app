import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'rating.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final Rating rating;
  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});
  @override
  List<Object?> get props =>
      [id, title, price, description, category, image, rating];
}
