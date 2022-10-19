import 'package:amazon/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
