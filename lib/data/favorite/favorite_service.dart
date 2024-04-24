import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutflix/data/index.dart';
import 'package:get/get.dart';

class FavoriteService extends GetxService {
  FavoriteService();

  Movie _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return Movie.fromJson(snapshot.data()!);
  }

  Map<String, dynamic> _toFirestore(Movie value, SetOptions? options) {
    return value.toJson();
  }

  CollectionReference<Movie>? getFavoriteMovies() {
    try {
      final user = Get.find<AuthService>().user;
      if (user == null) return null;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorite_movies')
          .withConverter<Movie>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          );
    } catch (e) {
      return null;
    }
  }

  Future<bool> addFavorite(Movie movie) async {
    try {
      final user = Get.find<AuthService>().user;
      if (user == null) return false;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorite_movies')
          .doc(movie.id)
          .set(movie
              .copyWith(timestamp: DateTime.now().microsecondsSinceEpoch)
              .toJson());
      return true;
    } catch (e) {
      Get.snackbar('Thông báo', e.toString());
      return false;
    }
  }

  Future<bool> removeFavorite(Movie movie) async {
    try {
      final user = Get.find<AuthService>().user;
      if (user == null || movie.id.isEmpty) return true;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorite_movies')
          .doc(movie.id)
          .delete();
      return false;
    } catch (e) {
      Get.snackbar('Thông báo', e.toString());
      return true;
    }
  }
}
