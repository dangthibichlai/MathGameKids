import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/model/list_game_model.dart';
import 'package:template/presentation/pages/addition/addition_controller.dart';
import 'package:template/presentation/widgets/animation_home.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';
import 'package:template/presentation/widgets/diaolog_select_dificult.dart';

class ContainerGridFunction extends GetView<AdditionController> {
  const ContainerGridFunction({
    this.isSkip,
    super.key,
    this.width,
    this.height,
    required this.item,
  });
  final double? width;
  final double? height;
  final bool? isSkip;
  final Game item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<SoundController>()) {
          Get.find<SoundController>().playClickGameSound();
        }
        showDialog(
            // cho nó full màn hình thì dùng showBaseDialog full screen
            // barrierColor: ColorResources.BACKGROUND.withOpacity(0.5),
            context: context,
            useSafeArea: false,
            builder: (BuildContext context) {
              return DialogSelectDificult(
                textStudy: item.name,
                isSkip: isSkip ?? false,
                routeNext: item.route ?? '',
              );
            });
      },
      child: Stack(
        children: [
          Container(
            height: IZISizeUtil.setSizeWithWidth(percent: .3),
            width: IZISizeUtil.getMaxWidth(),
            decoration: BoxDecoration(
              color: ColorResources.BLUE_MG,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: ColorResources.BLUE_MG_2, width: 5),
            ),
          ),
          Positioned(
            left: IZISizeUtil.setSizeWithWidth(percent: .03),
            bottom: IZISizeUtil.setSizeWithWidth(percent: .03),
            child: SizedBox(
              width: IZISizeUtil.setSizeWithWidth(percent: .24),
              child: AutoSizeText(
                item.name,

                // textHeightBehavior:
                //     const TextHeightBehavior(applyHeightToFirstAscent: false),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorResources.WHITE,
                      fontFamily: 'Filson',
                    ),
                maxLines: 2,
                softWrap: true,
              ),
            ),
          ),
          Positioned(
            right: IZISizeUtil.setSizeWithWidth(percent: .01),
            bottom: IZISizeUtil.setSizeWithWidth(percent: .04),
            child: GentleShakeImage(
              width: width ?? IZISizeUtil.setSizeWithWidth(percent: .18),
              height: height ?? IZISizeUtil.setSizeWithWidth(percent: .18),
              miliAnimation: 1000,

              // begin: -0.5,
              // end: 0.5,
              image: item.image,
            ),
          )
        ],
      ),
    );
  }
}
