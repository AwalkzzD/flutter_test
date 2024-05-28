import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sample/ui/api_call/get_users.dart';

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

    ref.listen<int>(counterStateProvider, (previous, current) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$current")));
    });

    return Scaffold(
      body: Center(
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
                child: const Text("Increment Counter")),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const GetUsers())),
                child: const Text("Api Call Screen"))
          ],
        ),
      ),
    );
  }
}
