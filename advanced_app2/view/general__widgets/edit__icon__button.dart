import 'package:flutter/material.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({Key? key, this.onTap}) : super(key: key);
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: const Icon(Icons.edit));
  }
}
