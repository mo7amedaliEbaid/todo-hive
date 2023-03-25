import 'package:flutter/material.dart';
import '../../utils/AppColors.dart';

class CustomActionIconButton extends StatelessWidget {
  const CustomActionIconButton({
    Key? key,
    required this.icon,
    this.shouldReverseColors = false,
  }) : super(key: key);
  final IconData icon;
  final bool shouldReverseColors;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: shouldReverseColors
              ? Theme.of(context).primaryColor
              : AppColors.lightGrey,
        ),
        padding: const EdgeInsets.all(15),
        child: Icon(
          icon,
          color: shouldReverseColors
              ? Theme.of(context).backgroundColor
              : AppColors.darkBlack,
        ),
      ),
    );
  }
}
