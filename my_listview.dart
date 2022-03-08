import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_last/news_details_screen.dart';

import 'main.dart';

class MyListView extends ConsumerWidget {
  final List<int> ids;
  const MyListView({Key? key, required this.ids}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: ids.length,
      itemBuilder: (BuildContext context, int index) {
        final newsAsyncValue = ref.watch(newsProvider(ids[index]));
        String sBy = 'news not available';
        newsAsyncValue.maybeWhen(
          data: (string) {
            sBy = string.by;
          },
          orElse: () => sBy,
        );
        return Column(
          children: [
            ListTile(
              tileColor: const Color(0xff123123),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailsScreen(id: ids[index])));
              },
              title: Text(
                ids[index].toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(width: 4.0),
                  // const Text('by'),
                  // const SizedBox(width: 4.0),
                  Text(sBy),
                ],
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
