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
  late PageController _movieCardPageController;
  late PageController _movieDetailPageController;

  double _pageMovieCard = 0.0;
  double _pageMovieDetails = 0.0;
  int _indexMovieCard = 0;
  bool _showMovieDetails = true;

  @override
  void initState() {
    _movieCardPageController = PageController(viewportFraction: 0.77)
      ..addListener(movieCardPagePercentListener);
    _movieDetailPageController = PageController()
      ..addListener(movieDetailsPagePercentListener);
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
                  final progress = (_pageMovieCard - index);
                  final scale = ui.lerpDouble(1, .8, progress.abs())!;
                  final isCurrentPage = index == _indexMovieCard;
                  final isScrolling = _movieCardPageController
                      .position.isScrollingNotifier.value;
                  final isChangingPage = index == 0;

                  return Transform.scale(
                    alignment: Alignment.lerp(
                      Alignment.topLeft,
                      Alignment.center,
                      -progress,
                    ),
                    scale: isScrolling && isChangingPage ? 1 - progress : scale,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMovieDetails = !_showMovieDetails;
                        });
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
                          setState(() {
                            _showMovieDetails = !_showMovieDetails;
                          });
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
                  final opacity = (index - _pageMovieDetails).clamp(0.0, 1.0);
                  final movie = movies[index];

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
                          Visibility(
                            visible: _showMovieDetails,
                            child: Text(
                              movie.actors.join(', '),
                              style: AppTextStyles.movieDetails,
                            ),
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

  movieCardPagePercentListener() {
    setState(() {
      _pageMovieCard = _movieCardPageController.page!;
      _indexMovieCard = _movieCardPageController.page!.round();
    });
  }

  movieDetailsPagePercentListener() {
    setState(() {
      _pageMovieDetails = _movieDetailPageController.page!;
    });
  }

  @override
  void dispose() {
    _movieCardPageController
      ..removeListener(movieCardPagePercentListener)
      ..dispose();
    _movieDetailPageController
      ..removeListener(movieDetailsPagePercentListener)
      ..dispose();
    super.dispose();
  }
}
