import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddProductScreen());
        },
        tooltip: 'Add a product',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
