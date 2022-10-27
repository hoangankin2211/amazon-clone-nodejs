import 'package:amazon/features/home/widgets/search_product_item.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';

class ProductGird extends StatelessWidget {
  const ProductGird({super.key, required this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) => Card(
        elevation: 5,
        child: SearchProductItem(
          product: products.elementAt(index),
        ),
      ),
      itemCount: products.length,
    );
  }
}
