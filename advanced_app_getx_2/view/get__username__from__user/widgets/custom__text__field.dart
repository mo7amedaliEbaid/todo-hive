import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "your name",
  });
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: hintText,
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        )),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        )),
      ),
    );
  }
}
