import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';
import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

import 'animations/animations.dart';
import 'widgets/widgets.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: -h * .1,
                height: h * .6,
                width: w,
                child: Hero(
                  tag: movie.image,
                  child: MovieCard(image: movie.image),
                ),
              ),
              Positioned(
                width: w,
                height: h * .5,
                child: Column(
                  children: [
                    const Spacer(),
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
                    OpacityTween(
                      begin: 0.0,
                      child: SlideUpTween(
                        begin: const Offset(-30, 30),
                        child: MovieStars(stars: movie.stars),
                      ),
                    ),
                    const Spacer(),
                    OpacityTween(
                      child: SlideUpTween(
                        begin: const Offset(0, 200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * .1),
                          child: Text(
                            movie.description,
                            style: AppTextStyles.movieDescriptionStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OpacityTween(
                      child: SlideUpTween(
                        begin: const Offset(0, 200),
                        duration: const Duration(milliseconds: 850),
                        child: MovieInfoTable(movie: movie),
                      ),
                    ),
                    const Spacer(flex: 5)
                  ],
                ),
              ),
              Positioned(
                bottom: h * .03,
                height: h * .06,
                width: w * .7,
                child: OpacityTween(
                  child: SlideUpTween(
                    begin: const Offset(-30, 60),
                    child: BookButton(movie: movie),
                  ),
                ),
              ),
              Positioned(
                bottom: h * .05,
                child: const OpacityTween(
                  child: SlideUpTween(
                    begin: Offset(-30, 60),
                    child: IgnorePointer(
                      child: Text(
                        'Book Ticket',
                        style: AppTextStyles.bookButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
