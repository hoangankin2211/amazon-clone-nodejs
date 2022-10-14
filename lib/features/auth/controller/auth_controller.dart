import 'package:amazon/models/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/global_variables.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  late final Rx<String> _token;
  Rx<User> user = Rx<User>(User(
      email: '',
      id: '',
      address: 'address',
      name: 'name',
      password: 'password',
      type: 'type',
      token: 'token'));

  User? get getUser {
    return user.value;
  }

  void setUser(String temp) {
    user.value = User.fromJson(temp);
  }

  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        address: '',
        email: email,
        name: name,
        password: password,
        type: '',
        token: '',
      );

      final response = await http.post(
        Uri.parse('${GlobalVariables.uri}/api/signup'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: response,
          buildContext: context,
          onSuccess: () {
            showSnackBar(context, 'Account created !');
          });

      print(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalVariables.uri}/api/signin'),
        body: json.encode({
          "email": email,
          "password": password,
        }),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      final data = json.decode(response.body);
      String token = data['token'];
      // print(data);
      httpErrorHandle(
          response: response,
          buildContext: context,
          onSuccess: () async {
            // SharedPreferences sharePreference =
            //     await SharedPreferences.getInstance();
            print('Here');
            setUser(response.body);
            // await sharePreference.setString("token", token);
            Get.to(() => const HomeScreen());
            // showSnackBar(context, 'SignIn successfully');
          });
      // print(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
