import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../../general__widgets/action__button.dart';

class OpenContainerButton extends StatelessWidget {
  const OpenContainerButton(
      {Key? key, required this.screenToOpen, required this.icon})
      : super(key: key);

  final Widget screenToOpen;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: OpenContainer(
        closedElevation: 0,
        closedBuilder: (context, action) {
          return CustomActionIconButton(
            icon: icon,
          );
        },
        openBuilder: (context, action) {
          return screenToOpen;
        },
        closedColor: Theme.of(context).backgroundColor,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        openColor: Theme.of(context).backgroundColor,
        transitionDuration: const Duration(milliseconds: 400),
        transitionType: ContainerTransitionType.fadeThrough,
        
      ),
    );
  }
}
