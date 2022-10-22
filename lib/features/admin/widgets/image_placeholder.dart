import 'dart:io';

import 'package:amazon/features/admin/widgets/custom_select_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePlaceholder extends StatefulWidget {
  const ImagePlaceholder({super.key, required this.images});
  final List<File> images;
  @override
  State<ImagePlaceholder> createState() => ImagePlaceholderState();
}

class ImagePlaceholderState extends State<ImagePlaceholder> {
  late PageController controller;
  List<Image> imageList = [];

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  Future<bool> prepareImage() async {
    bool result = true;
    await Future(
      () {
        for (var image in widget.images) {
          imageList.add(
            Image.file(
              image,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        result = false;
      },
    );
    return result;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prepareImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data as bool) {
              return PageView(
                controller: controller,
                children: imageList
                    .map(
                      (image) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: image,
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return CustomSelectFile(
                height: Get.height * 0.35,
                width: Get.width,
                title: 'Select Product Image',
              );
            }
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
