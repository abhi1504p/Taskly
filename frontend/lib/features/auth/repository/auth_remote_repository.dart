import 'dart:convert';
import 'dart:io';

import 'package:frontend/core/constant/constant.dart';
import 'package:frontend/core/services/sp_service.dart';
import 'package:frontend/core/widget/app_text.dart';
import 'package:frontend/features/auth/repository/auth_local_repository.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  final spService = SpService();
  final authLocalRepository=AuthLocalRepository();

  Future<UserModel> signUp({
    required name,
    required email,
    required password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('${Constants.backendUri}/auth/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['msg'];
      }
      return UserModel.fromMap(jsonDecode(res.body));
    } on SocketException {
      throw 'No Internet connection';
    } catch (e) {
      throw e.toString();
    }
  }

  // login

  Future<UserModel> login({required email, required password}) async {
    try {
      final res = await http.post(
        Uri.parse('${Constants.backendUri}/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),

      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['msg'];
      }
      return UserModel.fromMap(jsonDecode(res.body));
    } on SocketException {
      throw 'No Internet connection';
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final token = await spService.getToken();

      if (token == null) {
        return null;
      }
      final res = await http.post(
        Uri.parse('${Constants.backendUri}/auth/tokenIsValid'),
        headers: {"Content-Type": "application/json", 'x-auth-token': token},
      );

      if (res.statusCode != 200 || jsonDecode(res.body) == false) {
        return null;
      }

      final userResponse = await http.get(
        Uri.parse('${Constants.backendUri}/auth'),
        headers: {"Content-Type": "application/json", 'x-auth-token': token},
      );

      if (userResponse.statusCode != 200) {
        throw jsonDecode(userResponse.body)['msg'];
      }
      return UserModel.fromMap(jsonDecode(userResponse.body));
    } catch (e) {
      final user=await authLocalRepository.getUser();

      return user;
    }
  }
}
