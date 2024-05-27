import 'package:flutter/material.dart';

enum ProgressType { loading, error }

class CustomProgressView extends StatelessWidget {
  final ProgressType progressType;

  const CustomProgressView({super.key, required this.progressType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: switch (progressType) {
            ProgressType.loading => Colors.green,
            ProgressType.error => Colors.red,
          },
        ),
      ),
    );
  }
}

/*color: ((progressType == ProgressType.LOADING)
? Colors.green
: Colors.red),*/
