import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Weather {
  final int temperature;
  Weather(this.temperature);
}

class WeatherNotifier extends StateNotifier<Weather> {
  WeatherNotifier(Weather state) : super(state ?? Weather(0));

  Future<void> getWeather(String city) async {
    // HTTP Request
    await Future.delayed(Duration(seconds: 3));
    state = Weather(Random().nextInt(35));
  }
}

final myNameProvider = StateProvider<String>((ref) => 'Gian Marco');

final cityStateProvider = StateProvider<String>((ref) => 'Roma');

final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier>((ref) {
  return WeatherNotifier(null);
});

final weatherFutureProvider = FutureProvider<Weather>((ref) async {
  final city = ref.watch(cityStateProvider).state;
  await Future.delayed(Duration(seconds: 3));
  return Weather(Random().nextInt(35));
});

void main() => runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderListener<Weather>(
        onChange: (BuildContext context, value) {
          print(value.temperature);
        },
        provider: weatherNotifierProvider.state,
        child: Scaffold(
          appBar: AppBar(
            title: Text('StateNotifierProvider'),
          ),
          body: Column(
            children: [
              SearchBar(),
              Expanded(child: MyWeatherWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cityController,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final city = _cityController.text.trim();
            context.read(weatherNotifierProvider).getWeather(city);
          },
          child: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class MyWeatherWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final weather = watch(weatherNotifierProvider.state);

    return Text(
      '${weather.temperature}°',
      style: TextStyle(fontSize: 50),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      onChange: (BuildContext context, value) {
        print(value);
      },
      provider: weatherFutureProvider,
      child: Scaffold(
        body: Center(
          child: CounterText(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(counterState).state =
                MyClass(context.read(counterState).state.count + 1, 'Ciao');
          },
        ),
      ),
    );
  }
}

final counterState = StateProvider<MyClass>((ref) {
  print('counterState update');
  return MyClass(0, 'Ciao');
});

final cProvider = Provider<MyClass>((ref) {
  return ref.watch(counterState).state;
});

class CounterText extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final count = watch(cProvider).count;
    print('CounterText BUILD');
    return Text(count.toString());
  }
}

class MyClass extends Equatable {
  final int count;
  final String name;

  MyClass(this.count, this.name);

  @override
  List<Object> get props => [count, name];
}
/*

class Hero {
  ...
}


final heroStreamProvider = StreamProvider.family<Hero, String>((ref,id) async* {
  final stream = FirebaseFirestore.instance.collection('heroes').doc(id).snapshots();
  await for (final snapshot in stream) {
    ...
    yield Hero.fromMap(snapshot.data());
  }
});

class MyHeroWidget extends ConsumerWidget {
  final String id;

  MyHeroWidget(this.id);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final heroStream = watch(heroStreamProvider(id));

    return heroStream.when(
        data: (hero) => Center(
          child: Text(hero.name),
        ),
        loading: () => Center(child: const CircularProgressIndicator()),
        error: (err, stack) => Text('Error: $err'));
  }
}*/
