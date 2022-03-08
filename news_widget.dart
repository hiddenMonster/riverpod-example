import 'package:flutter/material.dart';
import 'package:riverpod_last/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatelessWidget {
  final News news;
  final infoStyle = const TextStyle(
    fontSize: 20,
  );
  const NewsWidget({Key? key, required this.news}) : super(key: key);

  void _launchURL({String? sUrl}) async {
    if (!await launch(sUrl!)) throw 'Could not launch $sUrl';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            news.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            'Score: ${news.score}',
            style: infoStyle,
          ),
          Text(
            'By: ${news.by}',
            style: infoStyle,
          ),
          TextButton(
            onPressed: () {
              _launchURL(sUrl: news.url);
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
