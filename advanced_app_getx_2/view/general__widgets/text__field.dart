import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textColor,
    required this.backgroundColor,
    required this.counterBpxColor,
    required this.counterTextColor,
    required this.maxLength,
    this.suffixIcon,
    this.onChanged,
    this.titleWrittenLength,
    this.animationDuration = const Duration(milliseconds: 50),
    this.counterBoxScale,
    this.showCounter = false,
    this.isTextArea = false,
    this.hintColor = Colors.grey,
    this.autoFocus = false,
    this.contentPadding = const EdgeInsets.all(15),
  })  : assert(hintText != null, "hintText must not be null"),
        super(key: key);

  final void Function(String)? onChanged;
  final String? hintText;
  final Icon? suffixIcon;
  final bool showCounter, isTextArea, autoFocus;
  final EdgeInsets contentPadding;
  final TextEditingController? controller;
  final int? maxLength, titleWrittenLength;
  final double? counterBoxScale;
  final Duration animationDuration;
  final Color textColor,
      backgroundColor,
      counterBpxColor,
      counterTextColor,
      hintColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Visibility(
          visible: showCounter,
          child: Positioned(
            bottom: -5,
            right: 10,
            child: AnimatedScale(
              duration: animationDuration,
              scale: counterBoxScale ?? 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: counterBpxColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "$titleWrittenLength / $maxLength",
                  style: TextStyle(
                      color: counterTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        TextField(
          autofocus: autoFocus,
          maxLines: isTextArea ? 12 : 1,
          style: TextStyle(
            color: textColor,
          ),
          maxLength: maxLength,
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            // shrink the default counter
            counter: const SizedBox.shrink(),
            alignLabelWithHint: false,
            contentPadding: contentPadding,
            suffixIcon: suffixIcon,
            suffixIconColor: Theme.of(context).primaryColor,

            filled: true,
            fillColor: backgroundColor.withOpacity(.05),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
