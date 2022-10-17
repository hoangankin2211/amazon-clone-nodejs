import 'package:amazon/features/home/widgets/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.listData});

  final List<Map<String, String>> listData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Product(
          image: listData[index]['image']!,
          price: listData[index]['price']!,
          title: listData[index]['title']!,
        );
      },
    );
  }
}
