import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/get_products/domain/entities/product.dart';
import '../../../../core/errors/failures.dart';
import 'products_events.dart';
import 'products_states.dart';
import '../../domain/usecases/get_products.dart';
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  ProductsBloc(this.getProducts) : super(ProductsInitalState()) {
    on<LoadProductsEvent>(_onStarted);
  }
  void _onStarted(LoadProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());
    final data = await getProducts();
    _eitherLoadedOrErrorState(data,emit);
  }

   _eitherLoadedOrErrorState(
    Either<Failure, List<Product>> failureOrProduct,
     Emitter<ProductsState> emit
  ) async {
     failureOrProduct.fold(
      (l) => emit(ProductsErrorState(message: "Failed to load data, Please try again!")),
      (product) => emit(ProductsLoadedState(products: product)),
    );
  }
}
