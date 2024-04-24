import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutflix/components/index.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteMoviesGrid extends StatelessWidget {
  const FavoriteMoviesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Movie?>(
      query: Get.find<FavoriteService>()
          .getFavoriteMovies()!
          .orderBy('timestamp', descending: true),
      builder: (context, snapshot, child) {
        if (snapshot.isFetching) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .8,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: snapshot.docs.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }

            return MoviePosterCard(
              movie: snapshot.docs[index].data()!,
              size: Size.infinite,
            );
          },
        );
      },
    );
  }
}
