import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final helloWorldProvider = Provider((ref) {
  return "Hello";
});

/// state provider used to store simple state objects that can change
/// to change/access ref.read(counterStateProvider.notifier).state = "hello"
final counterStateProvider = StateProvider((ref) {
  return 1;
});

/// state notifier class
class Time extends StateNotifier<DateTime> {
  late final Timer _timer;

  Time() : super(DateTime.now()) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

/// state notifier provider, used when change in state is needed on user interaction event
final timeProvider = StateNotifierProvider<Time, DateTime>((ref) {
  return Time();
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HelloWorldWidget(),
    );
  }
}

/// FutureProvider used when calling api, or calling a method where return type is Future
/// often used with autoDispose -  to cancel the HTTP request if the user leaves the screen before the Future completed.
/// or destroy the state of provider when no longer in use

/// when using future provider, you can also handle state of data, for ex.
///
///    final apiResponseAsync = ref.watch(apiResponseProvider);
///
///    apiResponseAsync.when(
///       data: (responseType) => {Text(responseType)},
///       error: (error, stack) => {Toast(error)},
///       loading: () => {CircularProgressIndicator()},
///    );
final apiResponseProvider = FutureProvider.autoDispose((ref) {
// ApiRepository().getApiResponse(param 1, param 2); returns Future<ResponseType>
});

/// use ref.read(someProvider) when it is needed to read provider state only once, example in initState() or button onPressed to change state
/// use ref.watch(someProvider) when it is needed to listen/observe changes in provider, used in build() for widget rebuild

/// Caching - ref.keepAlive() inside contentProvider is used to preserve the state so that request wont fire again if the user leaves
/// and re-enters the same screen.

/// Timeout based Caching
//   final link = ref.keepAlive();
//
//   final timer = Timer(const Duration(seconds: 30), () {
//     link.close();
//   });
//
//   ref.onDispose(() => timer.cancel());

/// Extension function for re-usability
//  extension AutoDisposeRefCache on AutoDisposeRef {
//    void cacheFor(Duration duration) {
//      final link = keepAlive();
//      final timer = Timer(duration, () => link.close());
//      onDispose(() => timer.cancel());
//    }
//  }
//
//  final myProvider = Provider.autoDispose<int>((ref) {
//    ref.cacheFor(const Duration(minutes: 5));
//    return 42;
//  });

/// used generally in whole pages
class HomeConsumerWidget extends ConsumerWidget {
  const HomeConsumerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld);
  }
}

/// use when you have complex widget layout and want to rebuild only selected widget on data change
/// when you need to update a little chunk of your widget tree where re-rendering the whole tree is costly.
class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final helloWorld = ref.read(helloWorldProvider);
      return Text(helloWorld);
    });
  }
}

/// use ConsumerStatefulWidget when need of stateful widget, create state class by extending ConsumerState
class HelloWorldWidget extends ConsumerStatefulWidget {
  const HelloWorldWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends ConsumerState<HelloWorldWidget> {
  @override
  Widget build(BuildContext context) {
    final displayText = ref.watch(counterStateProvider);

/*final apiResponseAsync = ref.watch(apiResponseProvider);

    apiResponseAsync.when(
        data: (responseType) => {Text(responseType)},
        error: (error, stack) => {Toast(error)},
        loading: () => {CircularProgressIndicator()});*/

    ref.listen<int>(counterStateProvider, (previous, current) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$current")));
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Flutter Sample Project",
                style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Consumer(builder: (_, WidgetRef ref, __) {
                final time = ref.watch(timeProvider);

                return Text(
                  (DateFormat.Hms().format(time)),
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ),
                );
              }),
              Text(
                displayText.toString(),
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () =>
                      {ref.read(counterStateProvider.notifier).state++},
                  child: const Text("Increment Counter"))
            ],
          ),
        ),
      ),
    );
  }
}
