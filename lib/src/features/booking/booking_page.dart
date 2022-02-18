import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';
import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

// ignore: unused_import
import '../biometrics/biometrics_page.dart';
import '../biometrics/custom_biometrics_page.dart';
import 'animations/animations.dart';
import 'widgets/widgets.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late final BookingPageAnimationController _controller;

  @override
  void initState() {
    _controller = BookingPageAnimationController(
      buttonController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
      contentController: AnimationController(
        duration: const Duration(milliseconds: 750),
        vsync: this,
      ),
    );
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _controller.buttonController.forward();
      await _controller.buttonController.reverse();
      await _controller.contentController.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAnimatedOpacity(
            animation: _controller.topOpacityAnimation,
            child: MovieAppBar(title: widget.movie.name),
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              width: w,
              height: h * .9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * .075,
                        child: MovieDates(dates: widget.movie.dates),
                      ),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.topOpacityAnimation,
                      child: SizedBox(
                        height: h * .2,
                        width: w,
                        child: MovieTeatherScreen(
                          image: widget.movie.image,
                          maxHeigth: h,
                          maxWidth: w,
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: MovieSeats(seats: widget.movie.seats),
                    ),
                    const Spacer(),
                    CustomAnimatedOpacity(
                      animation: _controller.bottomOpacityAnimation,
                      child: const MovieSeatTypeLegend(),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  const transitionDuration = Duration(milliseconds: 400);

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: transitionDuration,
                      reverseTransitionDuration: transitionDuration,
                      pageBuilder: (_, animation, ___) {
                        return FadeTransition(
                          opacity: animation,
                          // child: const BiometricsPage(), Uses Lottie
                          child: const CustomBiometricsPage(),
                        );
                      },
                    ),
                  );
                },
                child: AnimatedBuilder(
                  animation: _controller.buttonController,
                  builder: (_, child) {
                    final size = _controller
                        .buttonSizeAnimation(
                          Size(w * .7, h * .06),
                          Size(w * 1.2, h * 1.1),
                        )
                        .value;
                    final margin =
                        _controller.buttonMarginAnimation(h * .03).value;
                    return Container(
                      width: size.width,
                      height: size.height,
                      margin: EdgeInsets.only(bottom: margin),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: h * .05,
              child: const IgnorePointer(
                child: Text(
                  'Buy Ticket',
                  style: AppTextStyles.bookButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
