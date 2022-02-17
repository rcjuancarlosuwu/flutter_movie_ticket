import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';

import 'movie_info_table_item.dart';

class MovieInfoTable extends StatelessWidget {
  const MovieInfoTable({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MovieInfoTableItem(title: 'Type', content: movie.type),
        MovieInfoTableItem(title: 'Hour', content: '${movie.hours} hour'),
        MovieInfoTableItem(title: 'Director', content: movie.director),
      ],
    );
  }
}
