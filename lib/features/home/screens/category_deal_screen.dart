import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDealScreen extends StatefulWidget {
  const CategoryDealScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  final homeController = Get.find<HomeController>();
  String category = Get.arguments as String;

  fetchCategoryProducts() async {
    return await homeController.fetchCategoryProducts(category: category);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(category);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchCategoryProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data as bool) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Keep shopping for $category',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      child: homeController.products.value.isEmpty
                          ? const Text('Empty', style: TextStyle(fontSize: 50))
                          : GridView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 15),
                              itemCount: homeController.products.value.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final product =
                                    homeController.products.value[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 130,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.network(
                                              product.images[0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                          left: 0,
                                          top: 5,
                                          right: 15,
                                        ),
                                        child: Text(
                                          product.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              }
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
