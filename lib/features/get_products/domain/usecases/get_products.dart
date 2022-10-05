import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetProducts {
  final ProductsRepository repository;
  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
