import 'package:flutter/material.dart';

import 'animations/animations.dart';
import 'widgets/widgets.dart';

class CustomBiometricsPage extends StatefulWidget {
  const CustomBiometricsPage({
    Key? key,
    this.customPaintSize = 200.0,
  }) : super(key: key);

  final double customPaintSize;

  @override
  State<CustomBiometricsPage> createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<CustomBiometricsPage>
    with SingleTickerProviderStateMixin {
  late final FaceIDAnimationController _controller;

  @override
  void initState() {
    _controller = FaceIDAnimationController(
      customPaintSize: widget.customPaintSize,
      controller: AnimationController(
        duration: const Duration(seconds: 4),
        vsync: this,
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _controller.fordward().then(
            (_) => Navigator.of(context).pop(),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(
            widget.customPaintSize,
            widget.customPaintSize,
          ),
          painter: FaceIDPainter(
            animation: _controller,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
