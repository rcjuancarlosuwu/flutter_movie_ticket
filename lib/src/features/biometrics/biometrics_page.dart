import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class BiometricsPage extends StatelessWidget {
  const BiometricsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          faceIDLottie,
          width: 250,
          height: 250,
          frameRate: FrameRate(60),
          repeat: false,
        ),
      ),
    );
  }
}
