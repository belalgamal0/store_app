import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_app/core/theme/widget_decoration.dart';
import '../../../../core/theme/dimensions.dart';
import '../../../../core/theme/text_theme.dart';
import '../../domain/entities/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:  EdgeInsets.all(Dimensions.minPadding),
        margin:  EdgeInsets.symmetric(vertical: Dimensions.minPadding),
        decoration:WidgetDecorations.greySemiCircular,
        child: Row(
          children: [
            CachedNetworkImage(
                imageUrl: product.image,
                width: Dimensions.mediumImageSize - 10,
                height:Dimensions.mediumImageSize,
                fit: BoxFit.fill),
             SizedBox(width: Dimensions.minPadding),
            Expanded(
              child: Text(
                product.title,
                style: AppTextTheme.black16Semi,
              ),
            ),
            Text(
              "${product.price} \$",
              style: AppTextTheme.teal14Bold,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/productDetails', arguments: product);
      },
    );
  }
}
