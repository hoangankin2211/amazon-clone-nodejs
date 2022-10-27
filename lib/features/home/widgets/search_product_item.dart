import 'package:amazon/features/home/widgets/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';

class SearchProductItem extends StatelessWidget {
  final Product product;
  const SearchProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ProductDetailScreen(product: product),
        );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.images[0],
              fit: BoxFit.cover,
              height: 135,
              width: 135,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                    ],
                  ),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  const Text('Eligible for FREE Shipping'),
                  const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
