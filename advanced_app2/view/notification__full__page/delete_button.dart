import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton(
      {Key? key,
      required this.newNotificationController,
      required this.reversedIndex,
      required this.onPressed})
      : super(key: key);

  final newNotificationController;
  final int reversedIndex;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 55,
        width: 55,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withOpacity(.15),
        ),
        child: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
          icon: Icon(
            Icons.delete,
            color: Colors.red[800],
          ),
        ),
      ),
    );
  }
}
