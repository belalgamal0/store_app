import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource{
    Future<List<ProductModel>> getProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource{
    final http.Client client;
    const ProductsRemoteDataSourceImpl({required this.client});
      @override
  Future<List<ProductModel>> getProducts() =>
      _getTriviaFromUrl();
Future<List<ProductModel>> _getTriviaFromUrl() async {

    final response = await client.get(
      Uri.https('fakestoreapi.com','/products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
            List jsonResponse = json.decode(response.body);
  List<ProductModel> models = jsonResponse.map((job) => ProductModel.fromJson(job)).toList();

      return models;
    } else {
      throw ServerException();
    }
  }
}