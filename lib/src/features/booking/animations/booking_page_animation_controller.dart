import 'package:flutter/material.dart';

class BookingPageAnimationController {
  final AnimationController buttonController;
  final AnimationController contentController;
  final Animation<double> bottomOpacityAnimation;
  final Animation<double> topOpacityAnimation;

  BookingPageAnimationController({
    required this.buttonController,
    required this.contentController,
  })  : topOpacityAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: contentController,
          curve: const Interval(0.1, 1, curve: Curves.fastOutSlowIn),
        )),
        bottomOpacityAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: contentController,
          curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
        ));

  Animation<Size> buttonSizeAnimation(Size min, Size max) {
    return Tween<Size>(begin: min, end: max).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  Animation<double> buttonMarginAnimation(double begin) {
    return Tween<double>(begin: begin, end: 0).animate(CurvedAnimation(
      parent: buttonController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  dispose() {
    buttonController.dispose();
    contentController.dispose();
  }
}
