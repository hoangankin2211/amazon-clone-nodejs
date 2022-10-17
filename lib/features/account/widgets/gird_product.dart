import 'package:flutter/material.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children:
          children.map((element) => CustomGridItem(child: element)).toList(),
    );
  }
}

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1.5,
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
      child: child,
    );
  }
}
