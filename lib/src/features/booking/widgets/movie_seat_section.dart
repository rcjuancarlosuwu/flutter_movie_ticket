import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

import 'movie_seat_box.dart';

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({
    Key? key,
    required this.seats,
    this.isFront = false,
  }) : super(key: key);

  final List<Seat> seats;
  final bool isFront;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: isFront ? 16 : 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (_, index) {
          final seat = seats[index];
          return MovieSeatBox(seat: seat);
        },
      ),
    );
  }
}
