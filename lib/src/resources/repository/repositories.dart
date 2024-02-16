import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dio.dart';

class UserRepository {
  var LOGIN = '/login';

  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'accessToken');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> persistToken(String token, String email) async {
  //   await storage.write(key: 'accessToken', value: token);
  //   await storage.write(key: 'email', value: email);
  //   await UserCubit().getUser(email);
  // }

  Future<void> deleteToken() async {
    storage.delete(key: 'accessToken');
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    Response response = await DioClient.post(LOGIN, {
      "userName": email,
      "password": password,
    });
    if (response.statusCode == 200) {
      return response.data['accessToken'];
    } else {
      return 'error';
    }
  }
}
