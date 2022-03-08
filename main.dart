import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_last/filter_switch.dart';
import 'package:riverpod_last/my_listview.dart';
import 'package:riverpod_last/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}

final dioProvider = Provider((_) => Dio());
final sharedPrefsInstanceProvider = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

final allNewsProvider = FutureProvider<List<int>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get(
      'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
  return List.from(response.data);
});

final newsProvider = FutureProvider.family<News, int>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio
      .get('https://hacker-news.firebaseio.com/v0/item/$id.json?print=pretty');
  if (response.statusCode == 200) {
    final News myData = News.fromJson(response.data);
    return myData;
  }
  return News(
    by: 'by',
    descendants: 0,
    id: id,
    kids: <int>[],
    score: 0,
    time: 0,
    title: 'no title',
    type: 'empty',
    url: '',
  );
});

final filteredNews = FutureProvider<List<int>>((ref) async {
  final allNews = await ref.watch(allNewsProvider.future);
  final favoriteNewsIds = ref.watch(favoriteNewsListProvider);
  final filteredEnabled = ref.watch(filterProvider.state).state;
  return filteredEnabled ? favoriteNewsIds : allNews;
});

final readPrefsProvider = FutureProvider((ref) async {
  final prefs = ref.watch(sharedPrefsInstanceProvider);
  List<String> sIdList = [];
  prefs.whenData((value) {
    sIdList = List.from(value.getStringList('favoriteNews') ?? []);
  });
  List<int> iIdList = [];
  if (sIdList.isNotEmpty) {
    for (int i = 0; i < sIdList.length; i++) {
      iIdList.add(int.parse(sIdList.elementAt(i)));
    }
    ref.watch(favoriteNewsListProvider.state).state.clear();
    ref.watch(favoriteNewsListProvider.state).state.addAll(iIdList);
  }
  ref.refresh(filteredNews);
});

final favoriteNewsListProvider = StateProvider<List<int>>((ref) {
  List<int> favoriteList = [];
  return favoriteList;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listProvider = ref.watch(filteredNews);
    final readPrefs = ref.watch(readPrefsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top News'),
          centerTitle: true,
          actions: const [
            FilterSwitchWidget(),
          ],
        ),
        body: listProvider.when(
          data: (list) {
            readPrefs.whenData((_) => null);
            return list.isNotEmpty
                ? MyListView(ids: list)
                : const Center(
                    child: Text('Preferred list is empty'),
                  );
          },
          error: (e, stacktrace) => Center(
            child: Text(
              e.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.refresh_outlined,
            size: 36.0,
          ),
          onPressed: () {
            ref.refresh(allNewsProvider);
          },
        ),
      ),
    );
  }
}

/*
url:
https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty
 */
