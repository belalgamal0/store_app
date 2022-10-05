import 'package:dartz/dartz.dart';
import 'package:store_app/features/get_products/data/models/product_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_data_source.dart';
import '../datasources/products_remote_data_source.dart';
typedef Future<List<ProductModel>> _ConcreteOrRandomChooser();

class ProductsRepositoryImpl implements ProductsRepository {
  final NetworkInfo networkInfo;
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  ProductsRepositoryImpl({required this.networkInfo,required this.remoteDataSource,required this.localDataSource});
 @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    return await _getProducts( 
      () {
      return remoteDataSource.getProducts();
    }
);
  }


   Future<Either<Failure,  List<Product>>> _getProducts(
            _ConcreteOrRandomChooser getConcreteOrRandom

  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheProducts(remoteTrivia,'ProductsTable');
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getCachedProducts("ProductsTable");
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}