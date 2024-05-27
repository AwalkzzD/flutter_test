import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/ui/hello_world/hello_world.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
