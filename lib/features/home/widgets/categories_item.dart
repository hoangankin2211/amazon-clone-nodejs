import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({super.key, required this.icon, required this.title});
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouteName.categoryDealScreen, arguments: title),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
