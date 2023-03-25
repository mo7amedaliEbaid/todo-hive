import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../utils/AppColors.dart';
import '../../utils/extensions/string_extension.dart';
import '../general__widgets/button.dart';
import 'Constants/dimensions.dart';
import 'widgets/graph__bars.dart';
import 'widgets/one_face_rounded_box.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBlack,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Positioned(
                          right: 0,
                          bottom: 0,
                          // please don't ask why this, it's just a hack, I've used 1.2% of my brain to this
                          left: 27 + 100 + 8,
                          child: OneFaceRoundedBox(
                            width: 0,
                            color: AppColors.lightGrey,
                            //
                            // width: GetStartedDimensions
                            //     .oneFaceRoundedBoxDim["width"] as double,
                            height: GetStartedDimensions
                                .oneFaceRoundedBoxDim["height"] as double,
                            roundedBy: GetStartedDimensions
                                    .oneFaceRoundedBoxDim["borderRadiusValue"]
                                as double,
                            hasTopLeftRounded: true,
                            hasBottomLeftRounded: true,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 10,
                                  bottom: 10,
                                  top: 10,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.darkBlack,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 27,
                          top: 0,
                          bottom: 0,
                          child: OneFaceRoundedBox(
                            hasBottomRightRounded: true,
                            hasBottomLeftRounded: true,
                            roundedBy: GetStartedDimensions
                                    .oneFaceRoundedBoxDim["borderRadiusValue"]
                                as double,
                            color: AppColors.lightGrey,
                            width: GetStartedDimensions
                                .oneFaceRoundedBoxDim['height'] as double,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(right: 27),
                      child: OneFaceRoundedBox(
                        hasBottomRightRounded: true,
                        hasTopRightRounded: true,
                        color: AppColors.lightGrey,
                        width: double.infinity,
                        height: GetStartedDimensions
                            .oneFaceRoundedBoxDim['height'] as double,
                        roundedBy: GetStartedDimensions
                                .oneFaceRoundedBoxDim["borderRadiusValue"]
                            as double,
                        child: Image.asset(
                          "assets/images/scribble.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(left: 27),
                      child: OneFaceRoundedBox(
                        hasBottomLeftRounded: true,
                        hasTopLeftRounded: true,
                        color: AppColors.lightGrey,
                        width: double.infinity,
                        height: GetStartedDimensions
                            .oneFaceRoundedBoxDim['height'] as double,
                        roundedBy: GetStartedDimensions
                                .oneFaceRoundedBoxDim["borderRadiusValue"]
                            as double,
                        child: Center(
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GraphBars(
                            barsBoundedBy: 5,
                            colors: [
                              AppColors.darkBlack,
                              AppColors.darkBlack.withOpacity(.5),
                            ],
                            values: const [
                              40,
                              30,
                              20,
                              40,
                              40,
                              60,
                              50,
                              10,
                            ],
                          ),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 27),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    "never forget \n anymore".capitalizeAllWordsFirstLetter(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      key: const Key("getStartedButton"),
                      radiusValue: 10,
                      shouldReverseColors: false,
                      onPressed: () {
                        Get.toNamed('/getUsername');
                      },
                      text: "get started".capitalizeAllWordsFirstLetter()),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
