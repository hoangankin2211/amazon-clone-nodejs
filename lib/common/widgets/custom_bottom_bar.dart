import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    super.key,
    required this.itemsData,
    required this.selectPage,
    required this.currentPage,
  });

  final int currentPage;
  final List<Map<String, dynamic>> itemsData;
  final Function(int) selectPage;
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentPage,
      items: widget.itemsData
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(
                e['icon'] as IconData,
              ),
              label: e['label'] as String,
            ),
          )
          .toList(),
      backgroundColor: GlobalVariables.backgroundColor,
      selectedItemColor: GlobalVariables.selectedNavBarColor,
      unselectedItemColor: GlobalVariables.unselectedNavBarColor,
      elevation: 5,
      onTap: widget.selectPage,
    );
  }
}
