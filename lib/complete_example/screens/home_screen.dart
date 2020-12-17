import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/error_widget.dart';
import '../widgets/filter_checkbox.dart';
import '../widgets/my_listview.dart';
import '../models/news.dart';
import '../widgets/loading_widget.dart';

final dioProvider = Provider((ref) => Dio());

final newsIdsProvider = FutureProvider<List<int>>((ref) async {
  print('Loading News Ids');
  await Future.delayed(Duration(seconds: 1));
  final response = await ref.read(dioProvider).get(
      'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
  return List<int>.from(response.data);
});

final newsProvider = FutureProvider.family<News, int>((ref, id) async {
  print('Loading News: $id');
  await Future.delayed(Duration(seconds: 1));
  final response = await ref
      .read(dioProvider)
      .get('https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
  return News.fromJson(response.data);
});

final filteredNews = FutureProvider<List<int>>((ref) async {
  print('Loading Filtered News');
  final newsIds = await ref.watch(newsIdsProvider.future);
  final favoriteNewsIds = ref.watch(favoriteNewsIdsProvider).state;
  final filteredEnabled = ref.watch(filterProvider).state;
  return filteredEnabled ? favoriteNewsIds : newsIds;
});

final favoriteNewsIdsProvider = StateProvider<List<int>>((ref) {
  print('favoriteNewsIds update');
  return <int>[];
});

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
        actions: [const FilterCheckBoxWidget()],
      ),
      body: Consumer(
        builder: (BuildContext context, ScopedReader watch, Widget child) {
          final heroesAsyncValue = watch(filteredNews);
          return heroesAsyncValue.when(
              data: (list) => MyListView(ids: list),
              loading: () => const LoadingWidget(),
              error: (error, stackTrace) => MyErrorWidget(error: error));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.refresh(newsIdsProvider);
        },
      ),
    );
  }
}
