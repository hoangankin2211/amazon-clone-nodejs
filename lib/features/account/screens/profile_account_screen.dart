import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widgets/account_button.dart';
import 'package:amazon/features/account/widgets/gird_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  fit: BoxFit.fill,
                  height: 50,
                  width: 140,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search_outlined),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 25, color: Colors.black),
                children: [
                  const TextSpan(text: 'Hello, '),
                  TextSpan(
                      text: GlobalVariables.userInfo?.name ?? 'User',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.45,
                  child:
                      AccountButton(text: GlobalVariables.textAccountButton[0]),
                ),
                SizedBox(
                    width: Get.width * 0.45,
                    child: AccountButton(
                        text: GlobalVariables.textAccountButton[1])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Get.width * 0.45,
                    child: AccountButton(
                        text: GlobalVariables.textAccountButton[2])),
                SizedBox(
                    width: Get.width * 0.45,
                    child: AccountButton(
                        text: GlobalVariables.textAccountButton[3])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Orders',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 29, 201, 192),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height * 0.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridProduct(
                children: [
                  Image.asset(
                    'assets/images/macbook.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/iphone.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/iphone.png',
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    'assets/images/macbook.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
