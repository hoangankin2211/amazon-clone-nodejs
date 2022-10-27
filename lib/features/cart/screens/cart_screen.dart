import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../widgets/cart_product.dart';
import '../widgets/cart_subtotal.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final user = GlobalVariables.userInfo!;
    print(user.carts);
    int sum = 0;
    user.carts
        .map((e) => sum +=
            (e['quantity'] as int) * (e['product'] as Product).price.toInt())
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      // onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 29, 201, 192).withOpacity(0.8),
                  const Color.fromARGB(255, 125, 221, 216).withOpacity(0.8),
                ],
                stops: const [0.5, 1.0],
              )),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 5, bottom: 5),
                horizontalTitleGap: 0,
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Delivery to Admin - 101 Lake, Wall Street,...',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                title: 'Proceed to Buy (${user.carts.length} items)',
                // onTap: () => navigateToAddress(sum),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: user.carts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
