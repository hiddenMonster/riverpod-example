import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String error;

  const MyErrorWidget({Key key, this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
