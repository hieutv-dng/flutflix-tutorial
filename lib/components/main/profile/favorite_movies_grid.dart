import 'package:flutflix/components/index.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutter/material.dart';

class FavoriteMoviesGrid extends StatelessWidget {
  const FavoriteMoviesGrid({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .8,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: movies.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return MoviePosterCard(
          movie: movies[index],
          size: Size.infinite,
        );
      },
    );
  }
}
