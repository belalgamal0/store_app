import 'package:flutter/material.dart';
import '../../features/get_products/domain/entities/product.dart';
import '../../features/get_products/presentation/pages/products_page.dart';
import '../../features/get_products/presentation/pages/product_details_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  ProductsPage());
      case '/productDetails':
        if (args is Product) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailsPage(
              product: args,
            ),
          );
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
