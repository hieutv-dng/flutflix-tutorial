import 'package:flutflix/components/index.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutter/material.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MoviePosterCard(
            movie: movies[index],
            size: const Size(150, 200),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
      ),
    );
  }
}
