import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_last/filter_switch.dart';
import 'package:riverpod_last/main.dart';

final filterStarProvider = StateProvider.family<bool, int>((ref, id) => false);

class IconStarButton extends ConsumerWidget {
  final int id;
  const IconStarButton({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool bIsFavorite = ref.watch(filterProvider.state).state;
    final prefs = ref.watch(sharedPrefsInstanceProvider);

    return IconButton(
      color: Colors.yellow[600],
      icon: myStarIcon(
          preferences:
              prefs.whenData((value) => value.getStringList('favoriteNews')!),
          id: id.toString(),
          ref: ref),
      onPressed: () async {
        String sId = id.toString();
        if (bIsFavorite == false) {
          ref.read(filterStarProvider(id).state).update((state) => true);
          prefs.whenData((value) {
            List<String> tempList = value.getStringList('favoriteNews') ?? [];
            tempList.add(sId);
            return value.setStringList('favoriteNews', tempList);
          });
          ref.refresh(readPrefsProvider);
        }
        if (bIsFavorite) {
          ref.read(filterStarProvider(id).state).update((state) => false);
          prefs.whenData((value) {
            List<String> tempList = value.getStringList('favoriteNews') ?? [];
            tempList.remove(sId);
            return value.setStringList('favoriteNews', tempList);
          });
          ref.refresh(readPrefsProvider);
        }
      },
    );
  }

  Icon myStarIcon(
      {required AsyncValue<List<String>> preferences,
      required String id,
      required WidgetRef ref}) {
    bool bIsFavorite =
        ref.watch(filterStarProvider(int.tryParse(id)!).state).state;
    List<String>? syncPreferences = [];
    preferences.whenData((value) => syncPreferences.addAll(value));

    if (syncPreferences.isNotEmpty && syncPreferences.contains(id)) {
      bIsFavorite = true;
    }
    return bIsFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border);
  }
}
