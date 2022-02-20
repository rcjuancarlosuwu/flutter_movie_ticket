import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/data/data.dart';
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';
import 'package:flutter_movie_ticket/src/features/movie/movie_page.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView>
    with SingleTickerProviderStateMixin {
  late final PageController _movieCardPageController;
  late final PageController _movieDetailPageController;

  double _movieCardPage = 0.0;
  double _movieDetailsPage = 0.0;
  int _movieCardIndex = 0;
  final _showMovieDetails = ValueNotifier(true);

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77)
      ..addListener(_movieCardPagePercentListener);
    _movieDetailPageController = PageController()
      ..addListener(_movieDetailsPagePercentListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final h = constraints.maxHeight;
        final w = constraints.maxWidth;

        return Column(
          children: [
            const Spacer(),
            //* Movie Cards
            SizedBox(
              height: h * 0.6,
              child: PageView.builder(
                controller: _movieCardPageController,
                clipBehavior: Clip.none,
                itemCount: movies.length,
                onPageChanged: (page) {
                  _movieDetailPageController.animateToPage(
                    page,
                    duration: const Duration(milliseconds: 500),
                    curve: const Interval(0.25, 1, curve: Curves.decelerate),
                  );
                },
                itemBuilder: (_, index) {
                  final movie = movies[index];
                  final progress = (_movieCardPage - index);
                  final scale = ui.lerpDouble(1, .8, progress.abs())!;
                  final isCurrentPage = index == _movieCardIndex;
                  final isScrolling = _movieCardPageController
                      .position.isScrollingNotifier.value;
                  final isFirstPage = index == 0;

                  return Transform.scale(
                    alignment: Alignment.lerp(
                      Alignment.topLeft,
                      Alignment.center,
                      -progress,
                    ),
                    scale: isScrolling && isFirstPage ? 1 - progress : scale,
                    child: GestureDetector(
                      onTap: () {
                        _showMovieDetails.value = !_showMovieDetails.value;
                        const transitionDuration = Duration(milliseconds: 550);
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: transitionDuration,
                            reverseTransitionDuration: transitionDuration,
                            pageBuilder: (_, animation, ___) {
                              return FadeTransition(
                                opacity: animation,
                                child: MoviePage(movie: movie),
                              );
                            },
                          ),
                        );
                        Future.delayed(transitionDuration, () {
                          _showMovieDetails.value = !_showMovieDetails.value;
                        });
                      },
                      child: Hero(
                        tag: movie.image,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          transform: Matrix4.identity()
                            ..translate(
                              isCurrentPage ? 0.0 : -20.0,
                              isCurrentPage ? 0.0 : 60.0,
                            ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(70),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 25,
                                offset: const Offset(0, 25),
                                color: Colors.black.withOpacity(.2),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(movie.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            //* Movie Details
            SizedBox(
              height: h * 0.25,
              child: PageView.builder(
                controller: _movieDetailPageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  final movie = movies[index];
                  final opacity = (index - _movieDetailsPage).clamp(0.0, 1.0);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * .1),
                    child: Opacity(
                      opacity: 1 - opacity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: movie.name,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                movie.name.toUpperCase(),
                                style: AppTextStyles.movieNameTextStyle,
                              ),
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: _showMovieDetails,
                            builder: (_, value, __) {
                              return Visibility(
                                visible: value,
                                child: Text(
                                  movie.actors.join(', '),
                                  style: AppTextStyles.movieDetails,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _movieCardPagePercentListener() {
    setState(() {
      _movieCardPage = _movieCardPageController.page!;
      _movieCardIndex = _movieCardPageController.page!.round();
    });
  }

  _movieDetailsPagePercentListener() {
    setState(() {
      _movieDetailsPage = _movieDetailPageController.page!;
    });
  }

  @override
  void dispose() {
    _movieCardPageController
      ..removeListener(_movieCardPagePercentListener)
      ..dispose();
    _movieDetailPageController
      ..removeListener(_movieDetailsPagePercentListener)
      ..dispose();
    super.dispose();
  }
}
