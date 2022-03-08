import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_last/icon_star_button.dart';
import 'package:riverpod_last/main.dart';
import 'package:riverpod_last/news_widget.dart';

class NewsDetailsScreen extends ConsumerWidget {
  final int id;
  const NewsDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsyncValue = ref.watch(newsProvider(id));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News details: $id',
            style: const TextStyle(fontSize: 16.0),
          ),
          actions: [
            IconStarButton(id: id),
          ],
        ),
        body: newsAsyncValue.maybeWhen(
          data: (news) => NewsWidget(news: news),
          orElse: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
