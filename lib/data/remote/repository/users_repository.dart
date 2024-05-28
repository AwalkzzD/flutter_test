import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sample/base/constants/api/app_api_calls.dart';
import 'package:sample/data/remote/model/user_response.dart';
import 'package:sample/data/remote/utils/dio_manager.dart';

class UsersRepository {
  /// api call to get users
  Future<List<UserResponse>?> getUsersRemote() async {
    try {
      return userResponseFromJson((await DioManager.getInstance()!.get(
              AppApiCalls.getUsers,
              options: Options(responseType: ResponseType.plain)))
          .data);
    } on DioException catch (ex) {
      debugPrint("${ex.type.name}: ${ex.message!}");
    }
    return null;
  }
}
