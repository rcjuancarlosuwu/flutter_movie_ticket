import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

import '../animations/animations.dart';

class FaceIDPainter extends CustomPainter {
  final FaceIDAnimationController animation;

  FaceIDPainter({
    required this.animation,
  }) : super(repaint: animation.controller);

  @override
  void paint(Canvas canvas, Size size) {
    //* Layout
    assert(size.width == size.height);
    final s = size.height; // side
    final oneHalf = s / 2;
    final oneThird = s / 3;
    final twoThird = 2 * oneThird;
    final center = Offset(oneHalf, oneHalf);
    final radius = math.min(oneHalf, oneHalf);

    //* Animations
    final moveR1 = animation.moveR1.value;
    final moveL1 = animation.moveL1.value;
    final moveR2 = animation.moveR2.value;
    final moveU1 = animation.moveU1.value;
    final moveD1 = animation.moveD1.value;
    final moveU2 = animation.moveU2.value;

    final moveX = moveR1 + moveL1 + moveR2;
    final moveY = moveU1 + moveD1 + moveU2;

    final canBlink =
        animation.controller.value >= .6 && animation.controller.value <= .65;
    final canShowCheck1 = animation.controller.value >= .9;
    final canShowCheck2 = animation.controller.value >= .95;
    final check1X = animation.check1X.value;
    final check1Y = animation.check1Y.value;
    final check2X = animation.check2X.value;
    final check2Y = animation.check2Y.value;
    final closeRRect = animation.closeRRect.value;
    final borderRadiusRRect = animation.borderRadiusRRect.value;
    final faceOpacity = animation.faceOpacity.value;

    //* General Paint
    final strokeWidth = s * 0.06;
    final facePaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = AppColors.primaryColor.withOpacity(faceOpacity)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //* Eyes
    final eyeLength = s * .1;
    final eyeBlinkPaint = Paint()
      ..strokeWidth = strokeWidth
      ..color = canBlink
          ? Colors.transparent
          : AppColors.primaryColor.withOpacity(faceOpacity)
      ..strokeCap = StrokeCap.round;
    final leftEyeP1 = Offset(oneThird + moveX, oneThird + moveY);
    final leftEyeP2 = Offset(oneThird + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(leftEyeP1, leftEyeP2, facePaint);
    final rightEyeP1 = Offset(twoThird + moveX, oneThird + moveY);
    final rightEyeP2 = Offset(twoThird + moveX, oneThird + eyeLength + moveY);
    canvas.drawLine(rightEyeP1, rightEyeP2, eyeBlinkPaint);

    //* Smyle
    final rect = Rect.fromCircle(
      center: Offset(center.dx + moveX, center.dy + moveY),
      radius: s * .225,
    );
    final startAngle = vector.radians(130);
    final endAngle = vector.radians(-90);
    canvas.drawArc(rect, startAngle, endAngle, false, facePaint);

    //* Nose
    final offsetFactor = s * 0.006;
    final noseOffsetX = s * 0.015;
    final noseOffsetY = s * 0.175;
    final noseHeight = s * 0.225;
    final noseWidth = s * 0.05;
    final nosePath = Path()
      ..moveTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY,
      )
      ..lineTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + moveY + noseOffsetY,
      )
      ..quadraticBezierTo(
        (oneHalf + noseOffsetX) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
        (oneHalf - noseWidth) + moveX * offsetFactor,
        oneThird + noseHeight + moveY,
      );
    canvas.drawPath(nosePath, facePaint);

    //* Borders
    final paintBorders = Paint()
      ..style = PaintingStyle.stroke
      ..color = AppColors.primaryColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final rRect = RRect.fromRectAndRadius(
      Rect.fromCircle(center: center, radius: radius),
      Radius.circular(borderRadiusRRect),
    );
    canvas.drawRRect(rRect, paintBorders);

    //* Border Separator
    final lines = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeWidth = s * 0.07;
    final closeOffsetYP1 = oneThird * (1 + closeRRect);
    final closeOffsetYP2 = oneThird * (2 - closeRRect);
    canvas.drawLine(
      Offset(0, closeOffsetYP1),
      Offset(0, closeOffsetYP2),
      lines,
    );
    canvas.drawLine(
      Offset(s, closeOffsetYP1),
      Offset(s, closeOffsetYP2),
      lines,
    );
    canvas.drawLine(
      Offset(closeOffsetYP1, 0),
      Offset(closeOffsetYP2, 0),
      lines,
    );
    canvas.drawLine(
      Offset(closeOffsetYP1, s),
      Offset(closeOffsetYP2, s),
      lines,
    );

    //* Borders Caps
    final circle = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.primaryColor
      ..strokeWidth = s * 0.025;
    final capRadius = s * .03;
    canvas.drawCircle(Offset(0, closeOffsetYP1), capRadius, circle);
    canvas.drawCircle(Offset(0, closeOffsetYP2), capRadius, circle);
    canvas.drawCircle(Offset(s, closeOffsetYP1), capRadius, circle);
    canvas.drawCircle(Offset(s, closeOffsetYP2), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP1, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP2, 0), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP1, s), capRadius, circle);
    canvas.drawCircle(Offset(closeOffsetYP2, s), capRadius, circle);

    //* Check
    final check1 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck1 ? AppColors.primaryColor : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(s * .275, oneHalf),
      Offset(check1X, check1Y),
      check1,
    );
    final check2 = Paint()
      ..strokeCap = StrokeCap.round
      ..color = canShowCheck2 ? AppColors.primaryColor : Colors.transparent
      ..strokeWidth = strokeWidth;
    canvas.drawLine(
      Offset(oneHalf, s * .7),
      Offset(check2X, check2Y),
      check2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
