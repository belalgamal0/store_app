import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/dimensions.dart';
import '../../../../core/theme/text_theme.dart';
import '../../domain/entities/product.dart';
import '../widgets/price_widget.dart';
import '../widgets/rate_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Container(
        padding: EdgeInsets.all(Dimensions.maxPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CachedNetworkImage(
                imageUrl: product.image,
                height: Dimensions.maxImageSize,
              )),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.minPadding / 2),
                child: Center(
                    child: Text(
                  product.title,
                  style: AppTextTheme.black16Semi,
                )),
              ),
              Text(product.description),
              SizedBox(height: Dimensions.mediumPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PriceWidget(productPrice: product.price),
                  RateWidget(
                      productRate: product.rating.rate,
                      usersRatedCount: product.rating.count)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
