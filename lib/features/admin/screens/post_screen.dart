import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/admin/controller/admin_controller.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/admin/widgets/post_screen_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  late final adminController = Get.find<AdminController>();

  // Future<bool> fetchAllDataProduct(BuildContext context) async {
  //   return await adminController.fetchAllProduct(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddProductScreen());
        },
        backgroundColor: Colors.transparent,
        tooltip: 'Add a product',
        child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
                shape: BoxShape.circle),
            child: const Icon(Icons.add_outlined)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: Get.height * 0.7, maxWidth: Get.width),
            child: GetBuilder<AdminController>(
              id: 'PostScreenGrid',
              builder: (context) {
                return PostScreenGrid(products: adminController.getListProduct);
              },
            ),
          ),
        ],
      ),
    );
  }
}
