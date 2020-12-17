import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// 1 TODO Aggiungi ProviderScope
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
/*

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CounterText(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(counterState).state =
              MyClass(context.read(counterState).state.count + 1, 'Ciao');
        },
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
*/
