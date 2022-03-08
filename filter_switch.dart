import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = StateProvider<bool>((ref) => false);

class FilterSwitchWidget extends ConsumerWidget {
  const FilterSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterEnabled = ref.watch(filterProvider.state).state;
    return Switch(
      thumbColor:
          MaterialStateProperty.resolveWith((_) => const Color(0xff123123)),
      value: filterEnabled,
      onChanged: (status) async {
        ref.read(filterProvider.state).update((state) => status);
      },
    );
  }
}
