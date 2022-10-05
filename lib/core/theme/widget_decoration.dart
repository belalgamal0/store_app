import 'package:flutter/material.dart';

import 'dimensions.dart';

class WidgetDecorations {
  static BoxDecoration greySemiCircular = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.grey.shade100),
    borderRadius: BorderRadius.all(Radius.circular(Dimensions.mediumPadding)),
  );
}
