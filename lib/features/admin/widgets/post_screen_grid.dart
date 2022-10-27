import 'package:amazon/features/admin/controller/admin_controller.dart';
import 'package:amazon/features/admin/widgets/post_screen_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';

class PostScreenGrid extends StatelessWidget {
  PostScreenGrid({super.key, required this.products});
  final List<Product> products;
  final adminController = Get.find<AdminController>();
  void deleteProduct(String id) async {
    await adminController.deleteProduct(id);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemBuilder: (context, index) => PostScreenItem(
        image: products[index].images.first,
        title: products[index].description,
        deleteProduct: () {
          deleteProduct(products[index].id!);
        },
        id: products[index].id ?? " ",
      ),
      itemCount: products.length,
    );
  }
}
