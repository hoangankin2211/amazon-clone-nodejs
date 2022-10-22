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

  List<String> categoriesItem = [
    'Mobiles',
    'Appliances',
    'Books',
    'Electronics',
    'Essentials',
    'Fashion'
  ];

  final List<Widget> pages = [
    const PostScreen(),
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
          buildContext: context,
          onSuccess: () {
            Get.showSnackbar(const GetSnackBar(
              title: 'Announcement',
              message: 'Add product successful',
            ));
          });

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
}
