import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/admin/widgets/custom_select_file.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/global_variables.dart';
import '../controller/admin_controller.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey formController = GlobalKey<FormState>();
  final adminController = Get.find<AdminController>();

  late Rx<String> currentText = adminController.categoriesItem[0].obs;

  TextEditingController productName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSelectFile(
                  height: Get.height * 0.35,
                  width: Get.width,
                  title: 'Select Product Image',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: productName, hintText: 'Product Name'),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: productName,
                  hintText: 'Descriptions',
                  maxLine: 5,
                ),
                const SizedBox(height: 5),
                CustomTextField(controller: productName, hintText: 'Price'),
                const SizedBox(height: 5),
                CustomTextField(controller: productName, hintText: 'Quantity'),
                const SizedBox(height: 5),
                Obx(() {
                  return DropdownButton(
                    elevation: 5,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    alignment: Alignment.center,
                    value: currentText.value,
                    items: adminController.categoriesItem
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      currentText.value = value ?? " ";
                    },
                  );
                }),
                CustomButton(
                  title: 'Sell',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
