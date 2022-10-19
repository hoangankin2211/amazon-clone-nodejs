import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_bottom_bar.dart';
import '../controller/admin_controller.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late final PageController pageController;

  final adminController = Get.put(AdminController());

  void selectPage(int value) {
    if ((adminController.pageNumber.value - value).abs() >= 2) {
      pageController.jumpToPage(value);
    } else {
      pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
    adminController.pageNumber.value = value;
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);

    pageController.addListener(() {
      adminController.pageNumber.value =
          pageController.page == null ? 0 : pageController.page!.toInt();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    adminController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fill,
                  height: 50,
                  width: 140,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: adminController.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return CustomBottomBar(
            currentPage: adminController.pageNumber.value,
            itemsData: adminController.bottomBarItemAdmin,
            selectPage: selectPage,
          );
        },
      ),
    );
  }
}
