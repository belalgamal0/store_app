import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_app/features/get_products/domain/entities/product.dart';
import 'package:store_app/features/get_products/domain/entities/rating.dart';
import 'package:store_app/features/get_products/domain/usecases/get_products.dart';
import 'package:mockito/annotations.dart';
import 'package:store_app/features/get_products/presentation/bloc/bloc.dart';
import 'products_bloc_test.mocks.dart';

@GenerateMocks([GetProducts])
void main() {
  late ProductsBloc bloc;
  late MockGetProducts mockGetProducts;
  setUp(() {
    mockGetProducts = MockGetProducts();
    bloc = ProductsBloc(mockGetProducts);
  });

  group('should get products', () {
    var products = const [
      Product(
          id: 1,
          title: "Fjallraven",
          price: 100.00,
          description: "description",
          category: "men's clothing",
          image: "img",
          rating: Rating(rate: 5.0, count: 10))
    ];

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        when(mockGetProducts()).thenAnswer((_) async => Right(products));
        // act
        bloc.add(LoadProductsEvent());
        await untilCalled(mockGetProducts());
        // assert
        verify(mockGetProducts());
      },
    );
  });
}
