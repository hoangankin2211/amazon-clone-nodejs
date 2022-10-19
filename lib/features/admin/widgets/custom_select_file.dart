import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelectFile extends StatelessWidget {
  const CustomSelectFile({
    super.key,
    required this.height,
    required this.width,
    required this.title,
  });

  final double height;
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 2,
      borderType: BorderType.RRect,
      radius: const Radius.circular(25),
      dashPattern: const [12, 3],
      child: Container(
        width: Get.width,
        height: Get.height * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.folder_open_outlined,
              color: Colors.black,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
