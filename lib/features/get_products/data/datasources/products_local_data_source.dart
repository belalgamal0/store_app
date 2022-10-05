import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductsLocalDataSource {
  /// Gets the cached [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Product>> getCachedProducts(String boxName);
   Future<Box<dynamic>> cacheProducts(List<ProductModel> items, String boxName);
}


class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final HiveInterface hive;

  ProductsLocalDataSourceImpl({required this.hive});

  @override
    getCachedProducts(String boxName) async {
    List<Product> boxList = <Product>[];
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }
    return boxList;    
  }

  @override
  cacheProducts(List<ProductModel> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.clear();
      openBox.addAll(items);
      return openBox;
  }
}
