import 'package:flutflix/data/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'favorite_movies_grid.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = MovieApi().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutflix'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Logout?',
                middleText: 'Are you sure you want to logout?',
                textCancel: 'Cancel',
                textConfirm: 'Logout',
                onConfirm: () {
                  Get.back();
                  Get.find<AuthService>().logout();
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAvatar(context),
          const SizedBox(height: 16),
          _buildFavoriteMovies(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final user = Get.find<AuthService>().user;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            user?.photoURL ?? '',
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.grey,
                size: 80,
              );
            },
          ),
        ),
        if (user?.displayName?.isNotEmpty ?? false)
          Column(
            children: [
              const SizedBox(height: 8),
              Text(user!.displayName!),
            ],
          )
      ],
    );
  }

  Widget _buildFavoriteMovies(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'My favorite movies',
            style: TextStyle(fontSize: 25),
          ),
        ),
        FutureBuilder(
          future: trendingMovies,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return FavoriteMoviesGrid(
                movies: snapshot.data!,
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ],
    );
  }
}
