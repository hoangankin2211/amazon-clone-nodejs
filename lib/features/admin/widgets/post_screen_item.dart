import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreenItem extends StatelessWidget {
  const PostScreenItem({super.key, required this.image, required this.title});
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            // width: Get.width * 0.4,
            // height: Get.height * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.grey.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/images/placeholder.png'),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(title), const Icon(Icons.delete_outlined)],
        )
      ],
    );
  }
}
