import 'package:flutter/material.dart';

// 2 TODO Implements FutureProvider<List<int> [newsIdsProvider]
// url: https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty
// 3 TODO Implements Consumer List<int> [newsIdsProvider] in HomeScreen
// 4 TODO Show results
// 5 TODO Implements FutureProvider [newsProvider] -> family
// url: https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty
// 6 TODO Implements Consumer in NewsDetailsScreen
// 7 TODO Show results and FutureProvider cache
// 8 TODO Implements FAB for force refresh of FutureProvider [newsIdsProvider]
// 9 TODO Show context.refresh(newsIdsProvider) results
// 10 TODO Implements autodispose modifier [newsProvider]
// 11 TODO Show autodispose results
// 12 TODO Refactoring [dioProvider]
// 13 TODO Implement filterProvider and FilterCheckBox widget in HomeScreen
// 14 TODO Implement Favorite IconButton on NewsDetailsScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: Center(
        child: Text('RIVERPOD EXAMPLE'),
      ),
    );
  }
}
