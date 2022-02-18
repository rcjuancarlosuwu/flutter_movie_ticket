import 'package:flutter/material.dart';

class FaceIDAnimationController {
  final AnimationController controller;
  final double customPaintSize;
  final Animation<double> moveR1;
  final Animation<double> moveL1;
  final Animation<double> moveR2;
  final Animation<double> moveU1;
  final Animation<double> moveD1;
  final Animation<double> moveU2;
  final Animation<double> closeRRect;
  final Animation<double> borderRadiusRRect;
  final Animation<double> faceOpacity;
  final Animation<double> check1X;
  final Animation<double> check1Y;
  final Animation<double> check2X;
  final Animation<double> check2Y;

  FaceIDAnimationController({
    required this.controller,
    required this.customPaintSize,
  })  : moveR1 = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 0.2, curve: Curves.fastOutSlowIn),
        )),
        moveL1 = Tween<double>(
          begin: 0,
          end: -35,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.2, 0.4, curve: Curves.fastOutSlowIn),
        )),
        moveU1 = Tween<double>(
          begin: 0,
          end: -10,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.2, 0.3, curve: Curves.fastOutSlowIn),
        )),
        moveD1 = Tween<double>(
          begin: 0,
          end: 15,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 0.4, curve: Curves.fastOutSlowIn),
        )),
        moveR2 = Tween<double>(
          begin: 0,
          end: 15,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
        )),
        moveU2 = Tween<double>(
          begin: 0,
          end: -5,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
        )),
        closeRRect = Tween<double>(
          begin: 0,
          end: 0.5,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.4, 0.6, curve: Curves.fastOutSlowIn),
        )),
        borderRadiusRRect = Tween<double>(
          begin: 50,
          end: 100,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.6, curve: Curves.fastOutSlowIn),
        )),
        faceOpacity = Tween<double>(
          begin: 1,
          end: 0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.825, 0.875, curve: Curves.fastOutSlowIn),
        )),
        check1X = Tween<double>(
          begin: customPaintSize * .275,
          end: customPaintSize * 0.5,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.9, 0.95, curve: Curves.fastOutSlowIn),
        )),
        check1Y = Tween<double>(
          begin: customPaintSize * 0.5,
          end: customPaintSize * 0.7,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.9, 0.95, curve: Curves.fastOutSlowIn),
        )),
        check2X = Tween<double>(
          begin: customPaintSize * 0.5,
          end: customPaintSize * 0.75,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.95, 1, curve: Curves.bounceOut),
        )),
        check2Y = Tween<double>(
          begin: customPaintSize * 0.7,
          end: customPaintSize * 0.3,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: const Interval(0.95, 1, curve: Curves.bounceOut),
        ));

  TickerFuture fordward() => controller.forward();

  void dispose() {
    controller.dispose();
  }
}
