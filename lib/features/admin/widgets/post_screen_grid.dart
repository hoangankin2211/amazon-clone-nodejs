import 'package:amazon/features/admin/widgets/post_screen_item.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class PostScreenGrid extends StatelessWidget {
  const PostScreenGrid({super.key, required this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemBuilder: (context, index) => PostScreenItem(
        image: products[index].images.first,
        title: products[index].description,
      ),
      itemCount: products.length,
    );
  }
}
