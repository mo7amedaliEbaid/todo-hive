import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../controllers/get__username__controller/extensions/count_length.dart';
import '../../controllers/get__username__controller/extensions/set_username_to_box.dart';
import '../../controllers/get__username__controller/get__username__controller.dart';
import '../../utils/AppColors.dart';
import '../../utils/extensions/string_extension.dart';
import '../general__widgets/button.dart';
import '../general__widgets/text__field.dart';

class GetUsernamePage extends GetView<GetUsernameController> {
  const GetUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: mq.height,
            maxWidth: mq.width,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 2,
                ),
                // This should change to own logo
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/Logo.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    AutoSizeText(
                      "what we can call you ?".capitalizeAllWordsFirstLetter(),
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlack,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GetBuilder<GetUsernameController>(
                      builder: (controller) {
                        return CustomTextField(
                          key: const Key("get username text field"),
                          counterTextColor: AppColors.white,
                          counterBpxColor: AppColors.darkBlack,
                          textColor: AppColors.darkBlack,
                          backgroundColor: AppColors.darkBlack.withOpacity(.4),
                          counterBoxScale: controller.usernameCountBoxScale,
                          titleWrittenLength: controller.usernameWrittenLength,
                          showCounter: true,
                          onChanged: (value) {
                            controller.countUsernameLength(value);
                          },
                          maxLength: controller.usernameMaxLength,
                          controller: controller.usernameTextFieldController,
                          hintText: "your name".capitalizeAllWordsFirstLetter(),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                GetBuilder<GetUsernameController>(
                  builder: (controller) {
                    return CustomButton(
                      key: const Key("get username button"),
                      isBtnColorForGetStarted: true,
                      onPressed: controller.usernameTextFieldController.text
                              .trim()
                              .isNotEmpty
                          ? () {
                              controller.setUserName(
                                controller.usernameTextFieldController.text
                                    .trim(),
                              );

                              Get.offAllNamed('/main');
                            }
                          : null,
                      shouldReverseColors: true,
                      text: "next".capitalizeAllWordsFirstLetter(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
