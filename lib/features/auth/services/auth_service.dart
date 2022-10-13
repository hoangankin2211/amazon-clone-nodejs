import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
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
}
