import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:store_app/features/get_products/data/models/product_model.dart';
import 'package:store_app/features/get_products/domain/entities/product.dart';

void main() {
  ProductModel tProductModel = const ProductModel(
      id: 1,
      title: "Fjallraven",
      price: 100.00,
      description: "description",
      category: "men's clothing",
      image: "img",
      rating: RatingModel(rate: 5.0, count: 10));

  test(
    'should be a subclass of Product entity',
    () async {
      // assert
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid product model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product.json'));
        // act
        final result = ProductModel.fromJson(jsonMap);
        // assert
        expect(result, tProductModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tProductModel.toJson();
        // assert
        final expectedMap = {
          "id": 1,
          "title": "Fjallraven",
          "price": 100.00,
          "description": "description",
          "category": "men's clothing",
          "image": "img",
          "rating": {"rate": 5.0, "count": 10}
        };
        expect(result, expectedMap);
      },
    );
  });
}
