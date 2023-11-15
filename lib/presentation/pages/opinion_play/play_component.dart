// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';

import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/widget/progress_time_component.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

// ignore: must_be_immutable
class PlayPage extends StatelessWidget {
  const PlayPage({
    Key? key,
    this.title,
    this.level,
    this.count,
    this.isSkip,
    this.colorAnswer,
    this.onTapSkip,
    required this.onTapAnswer,
    this.currentQuestion,
    this.answerColors,
    this.currentOptions,
    this.colorTextLevel,
    this.time,
    this.countCorrect,
    this.countWrong,
    this.countSkip,
    this.router,
    this.controller,
    this.defaultQuesion,
    this.isTrueFalse,
  }) : super(key: key);
  final String? title;
  final String? level;
  final Color? colorTextLevel;
  final int? count;
  // isSkip is true  phụ thuộc vào  thuộc tính isSkip của listGame
  final bool? isSkip;
  final String? currentQuestion;
  final Color? colorAnswer;
  final Function? onTapSkip;
  final Function onTapAnswer;
  final Map<int, Color>? answerColors;
  final List<int>? currentOptions;
  final bool? time;
  final int? countCorrect;
  final int? countWrong;
  final int? countSkip;
  final String? router;
  final bool? defaultQuesion;
  final bool? isTrueFalse;
  final AnimationController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      appBar: BaseAppBar(title: title ?? '', isPremium: false),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: IZISizeUtil.setEdgeInsetsOnly(
                  top: IZISizeUtil.setSizeWithWidth(
                      percent: .2 - (time ?? false ? .12 : .0)),
                  bottom: IZISizeUtil.setSizeWithWidth(percent: .08),
                  left: IZISizeUtil.setSizeWithWidth(percent: .1),
                  right: IZISizeUtil.setSizeWithWidth(percent: .1)),
              child: Column(
                children: [
                  if (time ?? false) const ProgressTime() else const SizedBox(),
                  SizedBox(
                    height: IZISizeUtil.setSizeWithWidth(percent: .06),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: IZISizeUtil.setSizeWithWidth(percent: .9),
                        height: IZISizeUtil.setSizeWithWidth(percent: .8),
                      ),
                      Container(
                        margin: IZISizeUtil.setEdgeInsetsOnly(
                          top: IZISizeUtil.setSizeWithWidth(percent: .02),
                        ),
                        alignment: Alignment.center,
                        width: IZISizeUtil.setSizeWithWidth(percent: .85),
                        height: IZISizeUtil.setSizeWithWidth(percent: .73),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius:
                              BorderRadius.circular(IZISizeUtil.RADIUS_3X),
                          border: Border.all(
                              color: ColorResources.LIGHT_BLUE, width: 5),
                        ),
                        child: defaultQuesion ?? true
                            ? Text(
                                currentQuestion ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: ColorResources.BLUE_BLACK,
                                        fontFamily: 'Filson'),
                              )
                            : ModifileQuesition(
                                currentQuestion: currentQuestion,
                              ),
                      ),
                      Positioned(
                        top: IZISizeUtil.SPACE_3X,
                        left: IZISizeUtil.SPACE_2X,
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: colorTextLevel ?? ColorResources.GREEN,
                              size: IZISizeUtil.setSize(percent: .015),
                            ),
                            const SizedBox(
                              width: IZISizeUtil.SPACE_1X,
                            ),
                            Text(
                              level ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorTextLevel ??
                                          ColorResources.GREEN,
                                      fontFamily: 'Filson'),
                            ),
                          ],
                        ),
                      ),
                      if (time ?? false)
                        const SizedBox()
                      else
                        Positioned(
                          top: 0,
                          left: IZISizeUtil.setSizeWithWidth(percent: .27),
                          child: Container(
                            alignment: Alignment.center,
                            width: IZISizeUtil.setSize(percent: .13),
                            height: IZISizeUtil.setSize(percent: .03),
                            decoration: BoxDecoration(
                              color: ColorResources.BACKGROUND,
                              borderRadius:
                                  BorderRadius.circular(IZISizeUtil.RADIUS_2X),
                            ),
                            child: Text(
                              '$count/10',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorResources.WHITE,
                                      fontFamily: 'Filson'),
                            ),
                          ),
                        ),
                      if (isSkip ?? false)
                        Positioned(
                          bottom: IZISizeUtil.setSizeWithWidth(percent: .09),
                          right: IZISizeUtil.setSizeWithWidth(percent: .04),
                          child: GestureDetector(
                            onTap: () {
                              onTapSkip!();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: IZISizeUtil.setSize(percent: .045),
                              height: IZISizeUtil.setSize(percent: .045),
                              decoration: BoxDecoration(
                                color: ColorResources.WHITE,
                                borderRadius: BorderRadius.circular(
                                    IZISizeUtil.RADIUS_2X),
                                border: Border.all(
                                    color: ColorResources.LIGHT_BLUE),
                              ),
                              child: const Icon(
                                Icons.double_arrow_rounded,
                                size: 30,
                                color: ColorResources.BACKGROUND,
                                weight: 800,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: GridView.builder(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                        left: IZISizeUtil.setSizeWithWidth(percent: .1),
                        right: IZISizeUtil.setSizeWithWidth(percent: .1)),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTrueFalse ?? false ? 1 : 2,
                      mainAxisSpacing: IZISizeUtil.SPACE_3X,
                      crossAxisSpacing: IZISizeUtil.SPACE_4X,
                      childAspectRatio: 1.28, //
                    ),
                    itemBuilder: (context, index) {
                      // ignore: prefer_final_locals
                      Map<int, Color> colorButton = answerColors ?? {};

                      return Obx(
                        () => GridViewContainer(
                          onTap: () {
                            print('count: $count');

                            onTapAnswer(index);
                            // controller.checkAnswer(
                            //     controller.currentOptions[index]);
                            // print(controller.answerColors[
                            //     controller.currentOptions[index]]);
                          },
                          // ignore: invalid_use_of_protected_member
                          titleText: '${currentOptions![index]}'.tr,

                          color: colorButton[currentOptions![index]] ??
                              ColorResources.MATHGAME_BUTTON_BG,
                          borderColor: colorButton[currentOptions![index]] ??
                              ColorResources.MATHGAME_BUTTON_BG,
                          // routerPage: MainRouters.EXPONENTS,
                          withBorder: 7,
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class ModifileQuesition extends StatelessWidget {
  const ModifileQuesition({
    Key? key,
    this.currentQuestion,
  }) : super(key: key);
  final String? currentQuestion;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w900,
              color: ColorResources.BLUE_BLACK,
              fontFamily: 'Filson',
            ),
        children: List.generate(
          currentQuestion!.length,
          (index) {
            return WidgetSpan(
              child: Container(
                width: 20, // Độ rộng của ô vuông
                height: 20, // Chiều cao của ô vuông
                decoration: const BoxDecoration(
                  color: ColorResources.LIGHT_BLUE, // Màu sắc của ô vuông
                ),
              ),
              alignment: PlaceholderAlignment.middle,
            );
          },
        ),
      ),
    );
  }
}
