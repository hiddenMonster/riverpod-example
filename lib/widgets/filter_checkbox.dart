import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final filterProvider = StateProvider<bool>((ref) => false);

class FilterCheckBoxWidget extends ConsumerWidget {
  const FilterCheckBoxWidget();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final filterEnabled = watch(filterProvider).state;
    return Checkbox(
        value: filterEnabled,
        onChanged: (value) {
          context.read(filterProvider).state = value;
        });
  }
}
