import 'package:flutter/material.dart';

void showSnackBar(BuildContext buildContext, String text) {
  ScaffoldMessenger.of(buildContext).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
