import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/news_details_screen.dart';

class Utils {
  static void goToNewsDetails(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewsDetailsScreen(id),
      ),
    );
  }
}
