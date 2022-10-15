import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/controller/auth_controller.dart';
import 'package:amazon/features/dashboard/controller/dashboard_controller.dart';
import 'package:amazon/features/home/controller/home_controller.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          GlobalVariables.userInfo!.name + GlobalVariables.userInfo!.password,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
