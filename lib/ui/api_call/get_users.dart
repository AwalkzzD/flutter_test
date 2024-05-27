import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/base/screens/base_widget.dart';
import 'package:sample/base/utils/widgets/custom_list_view.dart';

import '../../data/remote/model/user_response.dart';
import '../../data/remote/repository/users_repository.dart';

class GetUsers extends BaseWidget {
  const GetUsers({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _GetUsersState();
}

class _GetUsersState extends BaseWidgetState {
  @override
  Widget build(BuildContext context) {
    final response = ref.watch(apiResponseProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Get Users"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: response.when(
            data: (userApiResponse) {
              return CustomListView<UserResponse>(
                data: userApiResponse,
                titleBuilder: (user) => Text(user.name),
                leadingIcon: const Icon(Icons.person),
                onTap: (user) {
                  showSnackBar(user.name);
                },
                borderColor: Colors.green,
                borderWidth: 1.5,
                borderRadius: 12,
              );
            },
            error: (error, stack) => getErrorView(),
            loading: () => getLoadingView(),
          ),
        ),
      ),
    );
  }
}

final apiResponseProvider = FutureProvider.autoDispose((ref) {
  return UsersRepository().apiUsers();
});
