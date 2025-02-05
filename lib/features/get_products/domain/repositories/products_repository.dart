import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductsRepository{
  Future<Either<Failure, List<Product>>> getProducts();
}