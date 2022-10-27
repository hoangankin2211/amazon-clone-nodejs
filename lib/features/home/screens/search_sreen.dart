import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/home/controller/home_controller.dart';
import 'package:amazon/features/home/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin/widgets/post_screen_grid.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final query = Get.arguments as String;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    print(query);
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
      body: FutureBuilder(
          future: homeController.searchByName(name: query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data as bool) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 29, 201, 192)
                                  .withOpacity(0.8),
                              const Color.fromARGB(255, 125, 221, 216)
                                  .withOpacity(0.8),
                            ],
                            stops: const [0.5, 1.0],
                          )),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.only(left: 5, bottom: 5),
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
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: Get.height * 0.84 - 30,
                              maxWidth: Get.width),
                          child: ProductGird(
                            products: homeController.getListSearchingProduct,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
