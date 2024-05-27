import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/base/utils/widgets/custom_progress_view.dart';

abstract class BaseWidget extends ConsumerStatefulWidget {
  const BaseWidget({super.key});

  @override
  BaseWidgetState createState() => getState();

  BaseWidgetState getState();
}

abstract class BaseWidgetState<T extends BaseWidget> extends ConsumerState<T> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget getLoadingView() {
    return const CustomProgressView(progressType: ProgressType.loading);
  }

  void hideSoftInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget getErrorView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomProgressView(progressType: ProgressType.error),
        Text("something went wrong")
      ],
    );
  }
}
