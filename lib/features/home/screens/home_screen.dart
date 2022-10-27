import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/home/controller/home_controller.dart';
import 'package:amazon/features/home/widgets/appbar_title.dart';
import 'package:amazon/features/home/widgets/categories_item.dart';
import 'package:amazon/features/home/widgets/categories_list.dart';
import 'package:amazon/features/home/widgets/deal_of_day.dart';
import 'package:amazon/features/home/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.find<HomeController>();

  final List<Map<String, String>> listIconAndTitle = [
    {'title': 'Mobiles', 'icon': 'assets/images/mobiles.jpeg'},
    {'title': 'Appliances', 'icon': 'assets/images/appliances.jpeg'},
    {'title': 'Books', 'icon': 'assets/images/books.jpeg'},
    {'title': 'Electronics', 'icon': 'assets/images/electronics.jpeg'},
    {'title': 'Essentials', 'icon': 'assets/images/essentials.jpeg'},
    {'title': 'Fashion', 'icon': 'assets/images/fashion.jpeg'},
  ];

  final List<Map<String, String>> listData = [
    {
      'title': 'Macbook',
      'image': 'assets/images/macbook.png',
      'price': '̣̣990'
    },
    {
      'title': 'Iphone',
      'image': 'assets/images/iphone.png',
      'price': '̣̣1990',
    },
  ];

  void onTextFormFieldComplete(String query) {
    Get.toNamed(RouteName.searchScreen, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 1,
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: AppBarTitle(
          searchController: homeController.searchController,
          navigateToPage: onTextFormFieldComplete,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 100,
                width: Get.width * 0.9,
                child: CategoriesList(listIconAndTitle: listIconAndTitle),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: Get.height * 0.3,
                child: Image.network(
                  'https://hocmarketing.org/photos/detail-image-4/quang-cao-la-gi.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Deal of the day',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const DealOfDay(),
              const Divider(
                thickness: 1.5,
              ),
              SizedBox(
                height: Get.height * 0.4,
                child: ListItem(listData: listData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
