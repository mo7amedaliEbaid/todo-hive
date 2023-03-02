import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/settings__controller/change__username.dart';
import '../../../../general__widgets/action__button.dart';
import '../../../../general__widgets/text__field.dart';

class ChangeUsernameBottomSheetWidget extends StatelessWidget {
  ChangeUsernameBottomSheetWidget(
      {Key? key,
      required this.controller,
      required this.usernameWrittenLength,
      required this.usernameMaxLength,
      required this.onSuccess,
      required this.counterBoxScale})
      : super(key: key);

  TextEditingController? controller;
  int? usernameWrittenLength, usernameMaxLength;
  double? counterBoxScale;
  void Function() onSuccess;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      color: Theme.of(context).backgroundColor,
      child: GetBuilder<ChangeUsernameSetting>(
        init: ChangeUsernameSetting(context: context),
        builder: (changeUsernameSetting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GetBuilder<ChangeUsernameSetting>(
                builder: (changeUsernameSetting) {
                  return CustomTextField(
                    textColor: Theme.of(context).primaryColor,
                    counterBpxColor: Theme.of(context).primaryColor,
                    counterTextColor: Theme.of(context).backgroundColor,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(.2),
                    counterBoxScale:
                        changeUsernameSetting.usernameCountBoxScale,
                    showCounter: true,
                    onChanged: (value) {
                      changeUsernameSetting.countUsernameLength(value);
                    },
                    hintText: "Username",
                    maxLength: changeUsernameSetting.usernameMaxLength,
                    titleWrittenLength:
                        changeUsernameSetting.usernameWrittenLength,
                    controller: controller,
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GetBuilder<ChangeUsernameSetting>(
                    builder: (newNotificationController) {
                      return GestureDetector(
                        onTap: () {
                          controller!.text = "";
                          changeUsernameSetting.countUsernameLength("");
                          usernameWrittenLength = 0;
                        },
                        child: const CustomActionIconButton(
                            icon: Icons.restart_alt,
                            shouldReverseColors: false),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: onSuccess,
                    child: const CustomActionIconButton(
                        icon: Icons.done, shouldReverseColors: true),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
