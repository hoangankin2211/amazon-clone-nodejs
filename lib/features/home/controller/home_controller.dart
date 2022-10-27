import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var products = Rx<List<Product>>([]);
  final _searchProducts = Rx<List<Product>>([]);
  final TextEditingController searchController = TextEditingController();

  List<Product> get getListSearchingProduct {
    return _searchProducts.value;
  }

  Future<bool> fetchCategoryProducts({required String category}) async {
    try {
      print(GlobalVariables.uri + ApiAddress.getAllProductCategory + category);
      final response = await http.get(
        Uri.parse(
            GlobalVariables.uri + ApiAddress.getAllProductCategory + category),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          final extractData = jsonDecode(response.body) as List<dynamic>;
          for (var element in extractData) {
            products.value
                .add(Product.fromMap(element as Map<String, dynamic>));
          }
        },
      );

      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> searchByName({required String name}) async {
    try {
      _searchProducts.value.clear();
      final response = await http.get(
        Uri.parse('${GlobalVariables.uri}${ApiAddress.searchProduct}/$name'),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          final extractData = jsonDecode(response.body) as List<dynamic>;
          for (var element in extractData) {
            _searchProducts.value
                .add(Product.fromMap(element as Map<String, dynamic>));
          }
        },
      );
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<Product?> fetchDealOfTheDay() async {
    Product? product;
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.uri + ApiAddress.dealOfTheDay),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      print('fetchDealOfTheDay: $e');
      product = null;
    }
    return product;
  }

  Future<bool> addProductToCart(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(GlobalVariables.uri + ApiAddress.addProductToCart),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
        body: jsonEncode({'idProduct': product.id}),
      );

      httpErrorHandle(
        response: response,
        onSuccess: () {
          final extractedData =
              jsonDecode(response.body) as Map<String, dynamic>;

          print(extractedData);

          // GlobalVariables.userInfo!.carts.add(
          //   {
          //     'product': product,
          //     'quantity': extractedData['quantity'] as int,
          //   },
          // );

          bool isExistedInCart = false;

          for (var element in GlobalVariables.userInfo!.carts) {
            if ((element['product'] as Product).id == product.id) {
              print('here');
              isExistedInCart = true;
              element['quantity'] = extractedData['quantity'] as int;
              break;
            }
          }

          if (isExistedInCart == false) {
            GlobalVariables.userInfo!.carts.add(
              {
                'product': product,
                'quantity': extractedData['quantity'] as int,
              },
            );
          }

          print(GlobalVariables.userInfo!.carts);
        },
      );

      return true;
    } catch (e) {
      print(' addProductToCart: ${e.toString()}');
      return false;
    }
  }
}
