import 'package:flutter/material.dart';

import '../utils.dart';

class MyListView extends StatelessWidget {
  final List<int> ids;

  const MyListView({Key key, this.ids}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ids.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Utils.goToNewsDetails(context, ids[index]);
          },
          title: Text(ids[index].toString()),
        );
      },
    );
  }
}
