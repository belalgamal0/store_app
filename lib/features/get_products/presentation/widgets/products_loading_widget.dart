import 'package:flutter/material.dart';

class ProductsLoadingWidget extends StatelessWidget {
  const ProductsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
