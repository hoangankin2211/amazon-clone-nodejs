import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.searchController,
    required this.navigateToPage,
  });
  final TextEditingController searchController;
  final void Function(String) navigateToPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: Border.all(width: 1.5, color: Colors.grey)),
            child: TextFormField(
              onFieldSubmitted: navigateToPage,
              controller: searchController,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search Amazon.in',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                prefixIcon: InkWell(
                  onTap: () => navigateToPage(searchController.text),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.mic,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
