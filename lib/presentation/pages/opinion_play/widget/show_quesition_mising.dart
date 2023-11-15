import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/play_mising_number/ui_models/missing_position_model.dart';
import 'package:template/presentation/pages/opinion_play/widget/number_text_missing.dart';
// import 'package:template/models/missing_position_model.dart';
// import 'package:template/presentation/pages/opinion_play/widget/number_text.dart';

class ShowQuesitionMissing extends StatelessWidget {
  const ShowQuesitionMissing(
      {super.key,
      this.title,
      this.level,
      this.colorTextLevel,
      this.count,
      this.isSkip,
      this.currentQuestion,
      this.onTapSkip,
      this.countCorrect,
      this.countWrong,
      this.countSkip,
      this.router,
      this.numberOder,
      this.position,
      this.num1,
      this.num2,
      this.result,
      this.operator,
      this.longAddition,
      this.inputAnswer,
      this.colorAnswer,
      this.colorMissing});
  final String? title;
  final String? level;
  final Color? colorTextLevel;
  final int? count;
  final bool? isSkip;
  final String? currentQuestion;
  final Function? onTapSkip;
  final int? countCorrect;
  final int? countWrong;
  final int? countSkip;
  final String? router;
  final int? numberOder;
  final int? position;
  final int? num1;
  final int? num2;
  final int? result;
  final String? inputAnswer;
  final String? operator;
  final bool? longAddition;
  final Color? colorAnswer;
  final Color? colorMissing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: IZISizeUtil.setEdgeInsetsOnly(
          top: IZISizeUtil.setSizeWithWidth(percent: .1),
          bottom: IZISizeUtil.setSizeWithWidth(percent: .08),
          left: IZISizeUtil.setSizeWithWidth(percent: .07),
          right: IZISizeUtil.setSizeWithWidth(percent: .07)),
      child: Column(
        children: [
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
                constraints: BoxConstraints(
                  maxWidth: IZISizeUtil.setSizeWithWidth(percent: .85),
                ),
                margin: IZISizeUtil.setEdgeInsetsOnly(
                  top: IZISizeUtil.setSizeWithWidth(percent: .02),
                ),
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  left: IZISizeUtil.setSizeWithWidth(percent: .02),
                  right: IZISizeUtil.setSizeWithWidth(percent: .02),
                ),
                alignment: Alignment.center,
                width: IZISizeUtil.setSizeWithWidth(percent: .85),
                height: IZISizeUtil.setSizeWithWidth(percent: .73),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_3X),
                  border:
                      Border.all(color: ColorResources.LIGHT_BLUE, width: 5),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: longAddition ?? false
                      ? __buildNumberTextLongAddition(
                          number1: num1 ?? 0,
                          number2: num2 ?? 0,
                          operator: operator ?? '',
                          result: inputAnswer ?? '',
                          colorAnswer:
                              colorAnswer ?? ColorResources.MATHGAME_BORDER,
                          context: context,
                        )
                      : _buildNumberTextMissing(
                          number1: num1 ?? 0,
                          number2: num2 ?? 0,
                          position: position ?? 0,
                          numberOder: numberOder ?? 0,
                          operator: operator ?? '',
                          result: result ?? 0,
                          context: context,
                          colorMissing:
                              colorMissing ?? ColorResources.MATHGAME_BORDER,
                        ),
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
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorTextLevel ?? ColorResources.GREEN,
                          fontFamily: 'Filson'),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: IZISizeUtil.setSizeWithWidth(percent: .27),
                child: Container(
                  alignment: Alignment.center,
                  width: IZISizeUtil.setSize(percent: .13),
                  height: IZISizeUtil.setSize(percent: .03),
                  decoration: BoxDecoration(
                    color: ColorResources.BACKGROUND,
                    borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_2X),
                  ),
                  child: Text(
                    '$count/10',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                        borderRadius:
                            BorderRadius.circular(IZISizeUtil.RADIUS_2X),
                        border: Border.all(color: ColorResources.LIGHT_BLUE),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget __buildNumberTextLongAddition(
      {required int number1,
      required int number2,
      required String operator,
      required String result,
      required Color colorAnswer,
      required BuildContext context}) {
    return SizedBox(
      width: IZISizeUtil.setSizeWithWidth(percent: .38),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              ' $number1',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                  fontFamily: 'Filson'),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                operator,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                    fontFamily: 'Filson'),
              ),
              Text(
                ' $number2',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                    fontFamily: 'Filson'),
              ),
            ],
          ),
          const Divider(
            color: ColorResources.BLACK,
            thickness: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: colorAnswer,
              borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_1X),
            ),
            constraints: const BoxConstraints(
              maxHeight: 40,
              // maxHeight:
            ),
            alignment: Alignment.centerRight,
            width: IZISizeUtil.setSizeWithWidth(percent: .4),
            child: Text(
              ' $result',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                  fontFamily: 'Filson'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberTextMissing(
      {required int number1,
      required int number2,
      required int position,
      required int numberOder,
      required String operator,
      required int result,
      required Color colorMissing,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberText(
          position: 0,
          missingPosition:
              MissingPositionModel(position: position, numberOrder: numberOder),
          number: number1,
          colorMissing: colorMissing,
        ),
        Text(
          operator,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorResources.BLACK,
              fontFamily: 'Filson'),
        ),
        NumberText(
          position: 1,
          missingPosition:
              MissingPositionModel(position: position, numberOrder: numberOder),
          number: number2,
          colorMissing: colorMissing,
        ),
        const Text(
          '=',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        NumberText(
          position: 2,
          missingPosition:
              MissingPositionModel(position: position, numberOrder: numberOder),
          number: result,
          colorMissing: colorMissing,
        ),
      ],
    );
  }
}
