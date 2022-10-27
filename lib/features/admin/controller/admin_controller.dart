import 'dart:convert';
import 'dart:io';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/admin/screens/post_screen.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../../models/product.dart';

class AdminController extends GetxController {
  var pageNumber = 0.obs;

  final List<Map<String, dynamic>> bottomBarItemAdmin = [
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.analytics_outlined, 'label': 'Analyst'},
    {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
  ];

  final List<String> categoriesItem = [
    'Mobiles',
    'Appliances',
    'Books',
    'Electronics',
    'Essentials',
    'Fashion'
  ];

  final List<Widget> pages = [
    PostScreen(),
    const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Text('analyzing'),
    ),
    Container(
      color: Colors.purple,
      height: double.infinity,
      width: double.infinity,
    ),
  ];
  Rx<List<Product>> products = Rx<List<Product>>([]);

  //////////////////////////////////////////
  @override
  void onClose() {
    products.close();
    super.onClose();
  }

  void _addProductToList(Product product) {
    products.value.add(product);
    update(['PostScreenGrid']);
  }

  void _deleteProductInList(String id) {
    products.value.removeWhere((element) => element.id == id);
    update(['PostScreenGrid']);
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchAllProduct(null);
  }
  //////////////////////////////////////////

  List<Product> get getListProduct {
    return products.value;
  }

  Future<List<File>> imagePicker() async {
    List<File> images = [];
    try {
      var fileResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (fileResult != null && fileResult.files.isNotEmpty) {
        for (var image in fileResult.files) {
          images.add(File(image.path!));
        }
      }

      return images;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> image,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dle0am3vl', 'yw9ea2cp');
      List<String> imagesUrl = [];

      for (var image in image) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imagesUrl.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imagesUrl,
        category: category,
        price: price,
      );

      print("token at sell product: ${GlobalVariables.userInfo!.token}");

      final response = await http.post(
        Uri.parse(GlobalVariables.uri + ApiAddress.sellProduct),
        headers: {
          "token": GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
        body: product.toJson(),
      );

      print(response.statusCode);

      httpErrorHandle(
        response: response,
        onSuccess: () {
          _addProductToList(product);
          Get.back();
          Get.showSnackbar(const GetSnackBar(
            title: 'Announcement',
            message: 'Add product successful',
            duration: Duration(seconds: 3),
          ));
        },
      );

      return true;
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: e.toString(),
        ),
      );
      return false;
    }
  }

  Future<bool> getProduct(String name, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.uri + ApiAddress.getProduct),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          'name': name,
          "Content-Type": 'application/json;charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: response,
        onSuccess: () {
          final extractData =
              json.decode(response.body) as Map<String, dynamic>;
          print(extractData.toString());
          // Product product = Product.fromMap(extractData['product']);
        },
      );
      return true;
    } catch (e) {
      print('getProduct: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String idProduct) async {
    try {
      print(idProduct);
      final response = await http.post(
        Uri.parse(GlobalVariables.uri + ApiAddress.deleteProduct),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
        body: jsonEncode({
          'id': idProduct,
        }),
      );

      final extractData = json.decode(response.body);

      _deleteProductInList(idProduct);

      print(extractData);

      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<bool> fetchAllProduct(BuildContext? context) async {
    try {
      final response = await http.get(
        Uri.parse(GlobalVariables.uri + ApiAddress.fetchAllProduct),
        headers: {
          'token': GlobalVariables.userInfo!.token,
          "Content-Type": 'application/json;charset=UTF-8',
        },
      );

      final extractData = json.decode(response.body) as List<dynamic>;
      products.value.clear();
      print(extractData);
      for (var element in extractData) {
        _addProductToList(Product.fromMap(element as Map<String, dynamic>));
      }
      httpErrorHandle(
        response: response,
        onSuccess: () {
          final extractData = json.decode(response.body) as List<dynamic>;
          for (var element in extractData) {
            products.value
                .add(Product.fromMap(element as Map<String, dynamic>));
          }
        },
      );

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
