import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/AppColors.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    Key? key,
    required this.mainController,
    required this.icon,
    required this.title,
    required this.description,
    this.hasSwitch = false,
    this.onSwitchChanged,
    this.switchValue,
    this.onTap,
  })  : assert(hasSwitch == (onSwitchChanged != null && switchValue != null),
            " hasSwitch presence require onSwitchChanged presence"),
        super(key: key);

  final mainController;
  final IconData icon;
  final String title, description;
  final bool hasSwitch;
  final bool? switchValue;
  final void Function(bool)? onSwitchChanged;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(.1),
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.05),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor.withOpacity(.45),
                    size: 35,
                  ),
                  if (hasSwitch) ...[
                    RepaintBoundary(
                      child: Switch(
                        value: switchValue ?? false,
                        onChanged: onSwitchChanged,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(.8),
                        activeColor: AppColors.darkBlack,
                      ),
                    ),
                  ]
                ],
              ),
              const Spacer(),
              AutoSizeText(
                mainController.allFirstWordLetterToUppercase(title),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AutoSizeText(
                  mainController.allFirstWordLetterToUppercase(description),
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
