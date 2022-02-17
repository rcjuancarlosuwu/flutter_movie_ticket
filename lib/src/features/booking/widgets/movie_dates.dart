import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

import 'movie_date_card.dart';

class MovieDates extends StatelessWidget {
  const MovieDates({
    Key? key,
    required this.dates,
  }) : super(key: key);

  final List<MovieDate> dates;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      clipBehavior: Clip.none,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: dates.length,
      itemBuilder: (context, index) {
        return MovieDateCard(
          date: dates[index],
          isSelected: index == 0,
        );
      },
    );
  }
}
