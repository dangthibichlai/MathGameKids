import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/presentation/pages/opinion_play/widget/progress_time_component.dart';

class ShowQuestion extends StatelessWidget {
  const ShowQuestion(
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
      this.time,
      this.height,
      this.padding,
      this.heightQuestion,
      this.width,
      this.isMultiplayer,
      this.color});
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
  final bool? time;
  final double? height;
  final double? width;
  final double? heightQuestion;
  final EdgeInsetsGeometry? padding;
  final bool? isMultiplayer;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          IZISizeUtil.setEdgeInsetsOnly(
              top: IZISizeUtil.setSizeWithWidth(
                  percent: .1 - (time ?? false ? .05 : 0)),
              //bottom: IZISizeUtil.setSizeWithWidth(percent: .02),
              left: IZISizeUtil.setSizeWithWidth(percent: .07),
              right: IZISizeUtil.setSizeWithWidth(percent: .07)),
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
                height:
                    heightQuestion ?? IZISizeUtil.setSizeWithWidth(percent: .9),
              ),
              Container(
                  margin: IZISizeUtil.setEdgeInsetsOnly(
                    top: IZISizeUtil.setSizeWithWidth(percent: .02),
                  ),
                  padding: IZISizeUtil.setEdgeInsetsOnly(
                      left: IZISizeUtil.SPACE_2X, right: IZISizeUtil.SPACE_2X),
                  alignment: Alignment.center,
                  width: width ?? IZISizeUtil.setSizeWithWidth(percent: .85),
                  height: height ?? IZISizeUtil.setSizeWithWidth(percent: .74),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color ?? ColorResources.WHITE,
                          ColorResources.WHITE,
                        ], // Màu đỏ và xanh
                        begin:
                            Alignment.bottomCenter, // Điểm bắt đầu ở dưới cùng
                        end: Alignment.topCenter, // Điểm kết thúc ở trên cùng
                      ),
                      //color: color ?? ColorResources.WHITE,
                      borderRadius:
                          BorderRadius.circular(IZISizeUtil.RADIUS_3X),
                      border: Border.all(
                          color: ColorResources.BD_CT_QUESITION, width: 5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: FittedBox(
                    child: Text(
                      currentQuestion ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontWeight: FontWeight.w900,
                              color: ColorResources.BLUE_BLACK,
                              fontFamily: 'Filson'),
                      maxLines: 1,
                    ),
                  )),
              Positioned(
                width: IZISizeUtil.setSizeWithWidth(percent: .88),
                top: IZISizeUtil.SPACE_3X,
                left: IZISizeUtil.SPACE_2X,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                                  color: colorTextLevel ?? ColorResources.GREEN,
                                  fontFamily: 'Filson'),
                        ),
                      ],
                    ),
                    if (isMultiplayer ?? false)
                      Row(
                        children: [
                          Text(
                            '$countCorrect',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: ColorResources.GREEN,
                                    fontFamily: 'Filson'),
                          ),
                          const SizedBox(
                            width: IZISizeUtil.SPACE_1X,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: ColorResources.GREEN,
                            size: 24,
                          )
                        ],
                      )
                    else
                      const SizedBox()
                  ],
                ),
              ),
              if (time ?? false)
                const SizedBox()
              else
                Positioned(
                  top: 0,
                  left: IZISizeUtil.setSizeWithWidth(percent: .32),
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
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorResources.WHITE,
                          fontFamily: 'Filson'),
                    ),
                  ),
                ),
              if (isSkip ?? false)
                Positioned(
                  bottom: IZISizeUtil.setSizeWithWidth(percent: .2),
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
              else
                const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
