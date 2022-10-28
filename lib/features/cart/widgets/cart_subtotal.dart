import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = GlobalVariables.userInfo!;
    int sum = 0;
    if (user.carts != null) {
      user.carts!
          .map((e) => sum +=
              (e['quantity'] as int) * (e['product'] as Product).price.toInt())
          .toList();
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\$$sum',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
