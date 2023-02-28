import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../controllers/settings__controller/change__username.dart';
import '../../../../controllers/settings__controller/dark__mode_setting.dart';
import '../../../../controllers/main__controller.dart';
import '../../../../controllers/settings__controller/delete__all__setting.dart';
import '../../../../controllers/settings__controller/enable__ongoing__setting.dart';
import '../../../../controllers/settings__controller/enable__sound.dart';
import '../../../../controllers/settings__controller/enable__vibration.dart';
import '../../../../controllers/settings__controller/show__delete__button__for__favorites.dart';
import '../../../../controllers/settings__controller/reset__all__settings.dart';
import '../../../../controllers/settings__controller/show__on__lock__screen__setting.dart';

import 'widgets/setting__card.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final MainController mainController = Get.put(MainController());
  final DeleteAllSetting deleteAllSetting = Get.put(DeleteAllSetting());
  final ResetAllSettings resetAllSettings = Get.put(ResetAllSettings());

  @override
  Widget build(BuildContext context) {
    final ChangeUsernameSetting changeUsernameSetting =
        Get.put(ChangeUsernameSetting(context: context));
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),

            AutoSizeText(
              mainController.allFirstWordLetterToUppercase("settings"),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            //

            //
            const SizedBox(height: 40),
            AutoSizeText(
              mainController
                  .allFirstWordLetterToUppercase("appearance & profile"),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            GridView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: <Widget>[
                GetBuilder<ThemeController>(
                  init: ThemeController(),
                  builder: (themeController) {
                    return SettingCard(
                      icon: Icons.brightness_2,
                      mainController: mainController,
                      description: "Switch app theme to dark / light mode",
                      title: "dark mode",
                      onTap: () {
                        themeController.toggleDarkMode();
                      },
                    );
                  },
                ),
                SettingCard(
                  icon: Icons.person,
                  mainController: mainController,
                  description: "change username and profile image",
                  title: "username",
                  onTap: () {
                    changeUsernameSetting.showEditUsernameBottomSheet();
                  },
                ),
                GetBuilder<ShowDeleteButtonForFavoritesSetting>(
                  init: ShowDeleteButtonForFavoritesSetting(),
                  builder: (hidedeleteButtonForFavoritesSetting) {
                    return SettingCard(
                      switchValue: hidedeleteButtonForFavoritesSetting
                          .isDeleteButtonHidden,
                      hasSwitch: true,
                      onSwitchChanged: (boolValue) {
                        hidedeleteButtonForFavoritesSetting
                            .isDeleteButtonHidden = boolValue;
                        hidedeleteButtonForFavoritesSetting
                            .setToHideDeleteButton(
                                hidedeleteButtonForFavoritesSetting
                                    .isDeleteButtonHidden);
                      },
                      icon: Icons.delete_forever,
                      mainController: mainController,
                      description: "hide delete button for favorites",
                      title: "delete button",
                      onTap: () {},
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            AutoSizeText(
              mainController.allFirstWordLetterToUppercase("features "),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            Opacity(
              opacity: .65,
              child: AutoSizeText(
                mainController.allFirstWordLetterToUppercase(
                    "( those changes will be applied after app restart )"),
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: <Widget>[
                GetBuilder<EnableOngoingSetting>(
                  init: EnableOngoingSetting(),
                  builder: (enableOngoingSetting) {
                    return SettingCard(
                      switchValue: enableOngoingSetting.isOngoingEnabled,
                      hasSwitch: true,
                      onSwitchChanged: (boolValue) {
                        enableOngoingSetting.isOngoingEnabled = boolValue;
                        enableOngoingSetting.setEnabledOngoing(
                            enableOngoingSetting.isOngoingEnabled);
                      },
                      icon: Icons.swipe,
                      mainController: mainController,
                      description: "make notifications non-dismissible",
                      title: "ongoing",
                      onTap: () {},
                    );
                  },
                ),
                GetBuilder<ShowOnLockScreenSetting>(
                  init: ShowOnLockScreenSetting(),
                  builder: (showOnLockScreenSetting) {
                    return SettingCard(
                      switchValue:
                          showOnLockScreenSetting.isHiddenOnLockedScreen,
                      hasSwitch: true,
                      onSwitchChanged: (boolValue) {
                        showOnLockScreenSetting.isHiddenOnLockedScreen =
                            boolValue;
                        showOnLockScreenSetting
                            .setNotificationVisibilityOnLockScreen(
                                showOnLockScreenSetting.isHiddenOnLockedScreen);
                      },
                      icon: Icons.screen_lock_portrait,
                      mainController: mainController,
                      description: "don't show on lock screen",
                      title: "screen lock",
                      onTap: () {},
                    );
                  },
                ),
                GetBuilder<EnableSoundSetting>(
                  init: EnableSoundSetting(),
                  builder: (enableSoundSetting) {
                    return SettingCard(
                      switchValue: enableSoundSetting.isSoundEnabled,
                      hasSwitch: true,
                      onSwitchChanged: (boolValue) {
                        enableSoundSetting.isSoundEnabled = boolValue;
                        enableSoundSetting.setEnabledSoundBool(
                            enableSoundSetting.isSoundEnabled);
                      },
                      icon: Icons.music_note,
                      mainController: mainController,
                      description: "enable sound for notification",
                      title: "sound",
                      onTap: () {},
                    );
                  },
                ),
                GetBuilder<EnableVibrationSetting>(
                  init: EnableVibrationSetting(),
                  builder: (enableVibrationSetting) {
                    return SettingCard(
                      switchValue: enableVibrationSetting.isVibrationEnabled,
                      hasSwitch: true,
                      onSwitchChanged: (boolValue) {
                        enableVibrationSetting.isVibrationEnabled = boolValue;
                        enableVibrationSetting.setEnabledVibration(
                            enableVibrationSetting.isVibrationEnabled);
                      },
                      icon: Icons.vibration,
                      mainController: mainController,
                      description: "enable vibration for notification",
                      title: "vibration",
                      onTap: () {},
                    );
                  },
                ),
                SettingCard(
                  icon: Icons.restart_alt,
                  mainController: mainController,
                  description: "reset all settings to default",
                  title: "reset ",
                  onTap: () {
                    resetAllSettings.reset();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            AutoSizeText(
              mainController.allFirstWordLetterToUppercase("delete all"),
              maxLines: 2,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            GridView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: <Widget>[
                SettingCard(
                  icon: Icons.delete,
                  mainController: mainController,
                  description:
                      "this will delete all your notifications at once",
                  title: "Delete all",
                  onTap: () {
                    deleteAllSetting.deleteAll();
                  },
                ),
              ],
            ),

          const SizedBox(height: 160,)
          ],
        ),
      ),
    );
  }
}
