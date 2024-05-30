import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sample/base/screens/base_widget.dart';
import 'package:sample/ui/api_call/get_users.dart';
import 'package:sample/ui/local_data/local_data.dart';

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
class HelloWorldWidget extends BaseWidget {
  const HelloWorldWidget({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends BaseWidgetState<HelloWorldWidget> {
  @override
  Widget build(BuildContext context) {
    final displayText = ref.watch(counterStateProvider);

    ref.listen<int>(counterStateProvider, (previous, current) {
      showSnackBar(current.toString());
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
                child: const Text("Remote Data")),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LocalData())),
                child: const Text("Local Data")),
          ],
        ),
      ),
    );
  }
}
