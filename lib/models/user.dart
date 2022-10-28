import 'dart:convert';
import 'package:amazon/models/product.dart';

class User {
  User({
    required this.email,
    required this.id,
    required this.address,
    required this.name,
    required this.password,
    required this.type,
    required this.token,
    required this.carts,
  });

  final String name;
  final String password;
  final String email;
  String address;
  final String id;
  final String type;
  final String token;
  List<Map<String, dynamic>>? carts;

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'id': id,
      'type': type,
      'token': token,
      'carts': jsonEncode(carts),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory User.fromJson(String source) {
    print("User.fromJson$source");
    Map<String, dynamic> temp = json.decode(source);

    List<dynamic> extractCartData = temp['cart'];
    List<Map<String, dynamic>> carts = [];

    for (var element in extractCartData) {
      Map<String, dynamic> data = {};
      (element as Map<String, dynamic>).forEach((key, value) {
        if (key == 'product') {
          data.addAll({key: Product.fromMap(value as Map<String, dynamic>)});
        } else if (key == 'quantity') {
          data.addAll({key: value as int});
        } else if (key == '_id') {
          data.addAll({key: value as String});
        }
      });

      carts.add(data);
    }

    print(carts);

    User user = User(
      email: temp['email'] ?? '',
      id: temp['id'] ?? '',
      address: temp['address'] ?? '',
      name: temp['name'] ?? '',
      password: temp['password'] ?? '',
      type: temp['type'] ?? '',
      token: temp['token'] ?? '',
      carts: carts,
    );
    return user;
  }

  void setUserAddress(String address) {
    this.address = address;
  }
}
