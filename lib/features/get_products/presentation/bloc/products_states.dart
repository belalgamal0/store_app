import 'package:store_app/features/get_products/domain/entities/product.dart';

abstract class ProductsState {}
class ProductsInitalState extends ProductsState {}
class ProductsLoadingState extends ProductsState {}
class ProductsLoadedState extends ProductsState {
  final List<Product> products;
  ProductsLoadedState({required this.products});
  @override
  List<Object> get props => [products];
}

class ProductsErrorState extends ProductsState {
  final String message;
  ProductsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
