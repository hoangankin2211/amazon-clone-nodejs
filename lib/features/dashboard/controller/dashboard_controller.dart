import 'package:amazon/features/account/screens/profile_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../home/screens/home_screen.dart';

class DashboardController extends GetxController {
  var pageNumber = 0.obs;

  final List<Map<String, dynamic>> bottomBarItem = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.person, 'label': 'Person'},
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
  ];

  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileAccountScreen(),
    Container(
        color: Colors.purple, height: double.infinity, width: double.infinity),
  ];
}
