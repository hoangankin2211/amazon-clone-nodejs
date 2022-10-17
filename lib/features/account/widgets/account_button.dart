import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: GlobalVariables.greyBackgroundCOlor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withOpacity(0.4),
          ),
          elevation: 0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
