import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/widgets/news_widget.dart';

import 'home_screen.dart';
import '../widgets/loading_widget.dart';

class NewsDetailsScreen extends ConsumerWidget {
  final int id;

  NewsDetailsScreen(this.id);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
        actions: [
          Consumer(
            builder: (BuildContext context,
                T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
              final favoriteIds = watch(favoriteNewsIdsProvider).state;
              final isFavorite = favoriteIds.contains(id);
              return IconButton(
                  icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                  color: Colors.yellow,
                  onPressed: () {
                    if (!isFavorite) {
                      context.read(favoriteNewsIdsProvider).state = [
                        ...favoriteIds,
                        id
                      ];
                    } else {
                      favoriteIds.remove(id);
                      context.read(favoriteNewsIdsProvider).state = favoriteIds;
                    }
                  });
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (BuildContext context, ScopedReader watch, Widget child) {
          final heroAsyncValue = watch(newsProvider(id));
          return heroAsyncValue.maybeWhen(
            data: (news) => NewsWidget(
              news: news,
            ),
            orElse: () => const LoadingWidget(),
          );
        },
      ),
    );
  }
}
