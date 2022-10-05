import 'package:flutter/material.dart';
import '../../../../core/theme/text_theme.dart';

class PriceWidget extends StatelessWidget {
  final double productPrice;
  const PriceWidget({super.key, required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: productPrice.toString(),
            style: AppTextTheme.black18Semi,
          ),
          TextSpan(text: '\$', style: AppTextTheme.teal14Bold),
        ],
      ),
    );
  }
}
