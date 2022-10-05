import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'injection_container.dart' as di;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/core/routes/route_generator.dart';
import 'features/get_products/domain/entities/product.dart';
import 'features/get_products/domain/entities/rating.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(RatingAdapter());
  await di.init();
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
