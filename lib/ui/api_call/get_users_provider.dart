import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/base/constants/api/app_api_calls.dart';
import 'package:sample/base/utils/extension_functions.dart';
import 'package:sample/data/remote/repository/users_repository.dart';

/// userRepositoryProvider returns UsersRepository object
final userRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository();
});

/// apiResponseProvider returns list of users
final apiResponseProvider = FutureProvider.autoDispose((ref) {
  final response = ref.read(userRepositoryProvider).getUsersRemote();

  /// cache provider ref for specified amount of time, after time expires, new request will be made when provider is called.
  ref.cacheFor(AppApiCalls.defaultResponseCacheTimeout);

  return response;
});
