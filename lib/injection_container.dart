import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/core/network/network_info.dart';
import 'features/get_products/domain/usecases/get_products.dart';
import 'features/get_products/presentation/bloc/products_bloc.dart';
import 'features/get_products/domain/repositories/products_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/get_products/data/repositories/products_repository_impl.dart';
import 'features/get_products/data/datasources/products_local_data_source.dart';
import 'features/get_products/data/datasources/products_remote_data_source.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Get Products
  // Bloc
  sl.registerFactory(
    () => ProductsBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(hive: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
