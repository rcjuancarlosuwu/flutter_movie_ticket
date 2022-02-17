import 'package:flutter/material.dart';

import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class MovieInfoTableItem extends StatelessWidget {
  const MovieInfoTableItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(title, style: AppTextStyles.infoTitleStyle),
        ),
        Text(content, style: AppTextStyles.infoContentStyle),
      ],
    );
  }
}
