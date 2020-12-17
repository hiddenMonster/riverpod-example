import 'package:flutter/material.dart';

import '../models/news.dart';

final infoStyle = TextStyle(
  fontSize: 22,
);

class NewsWidget extends StatelessWidget {
  final News news;

  const NewsWidget({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${news?.title ?? 'title'}',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            'Score: ${news?.score ?? '-'}',
            style: infoStyle,
          ),
          Text(
            'By: ${news?.by ?? '-'}',
            style: infoStyle,
          ),
          TextButton(
            onPressed: () {
              print(news?.url);
            },
            child: Text(
              'Go to news',
              style: infoStyle,
            ),
          ),
        ],
      ),
    );
  }
}
