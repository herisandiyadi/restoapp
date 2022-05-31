// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final String hint;

  final TextEditingController controller;

  const InputTextField({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: darkTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 44,
          width: double.infinity,
          color: softGreyColor,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: greyTextStyle,
              contentPadding: EdgeInsets.all(10),
            ),
            maxLines: 5,
            style: darkTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
        ),
      ],
    ));
  }
}
