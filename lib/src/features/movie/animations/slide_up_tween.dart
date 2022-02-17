import 'package:flutter/material.dart';

class SlideUpTween extends StatelessWidget {
  const SlideUpTween({
    Key? key,
    required this.begin,
    this.curve = Curves.easeOut,
    this.duration = const Duration(milliseconds: 750),
    required this.child,
  }) : super(key: key);

  final Offset begin;
  final Curve curve;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: begin, end: const Offset(0, 0)),
      curve: curve,
      duration: duration,
      builder: (_, value, child) {
        return Transform.translate(offset: value, child: child);
      },
      child: child,
    );
  }
}
