import 'package:store_app/features/get_products/domain/entities/product.dart';

import '../../domain/entities/rating.dart';

class ProductModel extends Product {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  }) : super(
            id: id,
            title: title,
            price: price,
            description: description,
            category: category,
            image: image,
            rating: rating);

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"].toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingModel.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toJson(),
      };
}

class RatingModel extends Rating {
  const RatingModel({
    required this.rate,
    required this.count,
  }) : super(rate: rate, count: count);

  final double rate;
  final int count;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"].toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}
