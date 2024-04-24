import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutflix/data/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _isLiked = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    Get.find<FavoriteService>()
        .getFavoriteMovies()
        ?.doc(widget.movie.id)
        .get()
        .then((value) {
      _isLiked.value = value.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverList.list(children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildOverview(context),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildReleaseDate(context),
                    const SizedBox(width: 8),
                    _buildRating(context)
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar.large(
      expandedHeight: 500,
      pinned: true,
      floating: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ValueListenableBuilder(
              valueListenable: _isLiked,
              builder: (context, isLiked, child) {
                return LikeButton(
                  isLiked: isLiked,
                  size: 36,
                  likeBuilder: (isLiked) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.star,
                        color: isLiked ? Colors.yellow : Colors.white,
                        size: 28,
                      ),
                    );
                  },
                  onTap: (liked) {
                    if (liked) {
                      return Get.find<FavoriteService>()
                          .removeFavorite(widget.movie);
                    } else {
                      return Get.find<FavoriteService>()
                          .addFavorite(widget.movie);
                    }
                  },
                );
              }),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(16),
        title: Text(
          widget.movie.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        background: CachedNetworkImage(
          imageUrl: widget.movie.posterPathUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.black12,
              child: IgnorePointer(child: Container(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.movie.overview,
          style: const TextStyle(fontSize: 25),
        ),
      ],
    );
  }

  Widget _buildRating(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text(
            'Rating: ',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.star, color: Colors.amber),
          Text(
            '${widget.movie.voteAverage.toStringAsFixed(1)}/10',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReleaseDate(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text(
            'Release date: ',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.movie.releaseDate,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
