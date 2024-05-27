import 'package:dio/dio.dart';
import 'package:sample/data/remote/model/user_response.dart';

class UsersRepository {
  Future<List<UserResponse>> apiUsers() async {
    return userResponseFromJson((await Dio().get(
            'https://dummyapi.online/api/user',
            options: Options(responseType: ResponseType.plain)))
        .data);
  }
}
