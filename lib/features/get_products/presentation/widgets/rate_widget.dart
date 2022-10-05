import 'package:flutter/material.dart';
import '../../../../core/theme/text_theme.dart';
import '../../../../core/theme/colors_theme.dart';

class RateWidget extends StatelessWidget {
  final double productRate;
  final int usersRatedCount;
  const RateWidget(
      {super.key, required this.productRate, required this.usersRatedCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(productRate.toString(), style: AppTextTheme.black16Semi),
        Icon(
          Icons.star,
          size: 20,
          color: AppColorTheme.yellowAccent
        ),
        Text("($usersRatedCount)")
      ],
    );
  }
}
