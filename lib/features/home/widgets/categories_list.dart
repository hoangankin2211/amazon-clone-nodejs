import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'categories_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.listIconAndTitle});
  final List<Map<String, String>> listIconAndTitle;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listIconAndTitle.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, index) {
        return CategoriesItem(
          icon: listIconAndTitle[index]['icon']!,
          title: listIconAndTitle[index]['title']!,
        );
      },
    );
  }
}
