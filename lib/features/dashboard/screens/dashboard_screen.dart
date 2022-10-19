import 'package:amazon/common/widgets/custom_bottom_bar.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/dashboard/controller/dashboard_controller.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final PageController pageController;

  final dashboardController = Get.find<DashboardController>();

  void selectPage(int value) {
    if ((dashboardController.pageNumber.value - value).abs() >= 2) {
      pageController.jumpToPage(value);
    } else {
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
    dashboardController.pageNumber.value = value;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);

    pageController.addListener(() {
      dashboardController.pageNumber.value =
          pageController.page == null ? 0 : pageController.page!.toInt();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    dashboardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: dashboardController.pages,
        ),
      ),
      backgroundColor: GlobalVariables.backgroundColor,
      bottomNavigationBar: Obx(() {
        return CustomBottomBar(
          currentPage: dashboardController.pageNumber.value,
          itemsData: dashboardController.bottomBarItemUser,
          selectPage: selectPage,
        );
      }),
    );
  }
}
