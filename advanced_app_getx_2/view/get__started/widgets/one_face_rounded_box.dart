import 'package:flutter/material.dart';

class OneFaceRoundedBox extends StatelessWidget {
  const OneFaceRoundedBox({
    Key? key,
    this.child,
    required this.color,
    required this.width,
    required this.height,
    this.hasTopLeftRounded = false,
    this.hasTopRightRounded = false,
    this.hasBottomLeftRounded = false,
    this.hasBottomRightRounded = false,
    this.allSidesRounded = false,
    required this.roundedBy,
  }) : super(key: key);
  final Color color;

  final Widget? child;
  final double height, width, roundedBy;
  final bool hasTopLeftRounded,
      hasTopRightRounded,
      hasBottomLeftRounded,
      hasBottomRightRounded,
      allSidesRounded;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        // border radius value and position controller by widget properties
        borderRadius: BorderRadius.only(
          topLeft: hasTopLeftRounded || allSidesRounded
              ? Radius.circular(roundedBy)
              : Radius.zero,
          topRight: hasTopRightRounded || allSidesRounded
              ? Radius.circular(roundedBy)
              : Radius.zero,
          bottomLeft: hasBottomLeftRounded || allSidesRounded
              ? Radius.circular(roundedBy)
              : Radius.zero,
          bottomRight: hasBottomRightRounded || allSidesRounded
              ? Radius.circular(roundedBy)
              : Radius.zero,
        ),
      ),
      child: child,
    );
  }
}
