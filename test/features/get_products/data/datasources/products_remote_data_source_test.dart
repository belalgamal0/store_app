import 'dart:io';
import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'products_remote_data_source_test.mocks.dart';
import 'package:store_app/core/errors/exceptions.dart';
import 'package:store_app/features/get_products/data/models/product_model.dart';
import 'package:store_app/features/get_products/data/datasources/products_remote_data_source.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductsRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductsRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('products.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getProducts', () {
    var productsList = json
        .decode(fixture('products.json'))
        .map((data) => ProductModel.fromJson(data))
        .toList();

    test(
      '''should perform a GET request on a URL
      and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getProducts();
        // assert

        verify(mockHttpClient.get(
          Uri.https('fakestoreapi.com', '/products'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return list of products when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getProducts();
        // assert
        expect(result, equals(productsList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getProducts;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
