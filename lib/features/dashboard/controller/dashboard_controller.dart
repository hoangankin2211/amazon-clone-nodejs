import 'package:amazon/features/account/screens/profile_account_screen.dart';
import 'package:amazon/features/cart/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../home/screens/home_screen.dart';

class DashboardController extends GetxController {
  var pageNumber = 0.obs;

  final List<Map<String, dynamic>> bottomBarItemUser = [
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.person_outlined, 'label': 'Person'},
    {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
  ];

  final List<Map<String, dynamic>> bottomBarItemAdmin = [
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.analytics_outlined, 'label': 'Analyst'},
    {'icon': Icons.shopping_cart_outlined, 'label': 'Cart'},
  ];

  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileAccountScreen(),
    const CartScreen(),
  ];
}
