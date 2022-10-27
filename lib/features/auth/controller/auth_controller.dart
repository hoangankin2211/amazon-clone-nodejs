import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/utils.dart';

import '../../../constants/global_variables.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final Rx<String?> _token = Rx<String?>(null);

  Rx<User?> user = Rx<User?>(null);

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
        carts: [],
      );
      final response = await http.post(
        Uri.parse(GlobalVariables.uri + ApiAddress.signUp),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          showSnackBar(context, 'Account created !');
        },
      );

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
        Uri.parse(GlobalVariables.uri + ApiAddress.signIn),
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

      httpErrorHandle(
          response: response,
          onSuccess: () async {
            SharedPreferences sharePreference =
                await SharedPreferences.getInstance();
            setUser(response.body);
            // showSnackBar(context, 'SignIn successfully');
            await sharePreference.setString("token", token);
            if (user.value!.type == 'user') {
              Get.offAndToNamed(RouteName.homeScreen);
            } else {
              Get.offAndToNamed(RouteName.adminScreen);
            }
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isTokenValid() async {
    try {
      final sharedPreference = await SharedPreferences.getInstance();
      String? token = sharedPreference.getString('token');
      if (token == null) {
        return false;
      }

      final response = await http.post(
        Uri.parse(GlobalVariables.uri + ApiAddress.checkToken),
        headers: {
          'token': token,
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      final finalResponse = json.decode(response.body);
      if (finalResponse['isValid']) {
        _token.value = token;
        setUser(response.body);
        print("user.value.id${user.value!.id}");
        print(user.value!.email);
      } else {
        _token.value = null;
      }

      return finalResponse['isValid'];
    } catch (e) {
      rethrow;
    }
  }
}
