import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class DotTabIndicator extends Decoration {
  const DotTabIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return const DotIndicatorPainter();
  }
}

class DotIndicatorPainter extends BoxPainter {
  const DotIndicatorPainter();

  static const radius = 8.0;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final c = Offset(
      configuration.size!.width / 2,
      configuration.size!.height + radius / 2,
    );

    final paint = Paint()
      ..color = AppColors.primaryColor
      ..isAntiAlias = true;

    canvas.drawCircle(c, radius, paint);
  }
}
