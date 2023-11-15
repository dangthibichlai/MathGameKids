import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/play_multiplayer_controller.dart';
import 'package:template/presentation/pages/opinion_play/play_multiplayer/player_model.dart';

import 'package:template/presentation/widgets/controller/sound_controller.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';
import 'package:template/presentation/widgets/result_components/container_result.dart';
import '../../../../core/helper/izi_size_util.dart';
import '../../../../core/utils/color_resources.dart';

class ResultMultiPlayerPage extends GetView<MultiPlayerController> {
  const ResultMultiPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Chặn trượt back tại trang này
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BG,
        body: SizedBox(
          height: IZISizeUtil.getMaxHeight(),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: _screenResult(context, controller.player1.value,
                            color: ColorResources.BG)),
                  ),
                  Expanded(
                    child: _screenResult(context, controller.player2.value,
                        color: ColorResources.BG_BT_PL2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenResult(BuildContext context, PlayerModel player,
      {Color? color}) {
    return Container(
      padding: EdgeInsets.only(
        left: IZISizeUtil.setSizeWithWidth(percent: .1),
        right: IZISizeUtil.setSizeWithWidth(percent: .1),
        // top: IZISizeUtil.setSizeWithWidth(percent: .08),
      ),
      height: IZISizeUtil.getMaxHeight() / 2,
      color: color ?? ColorResources.BLUE_MG,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (player.result == 'You Won'.tr)
            RotatedBox(
              quarterTurns: -2,
              child: Lottie.asset(
                'assets/logo/resultMultiplayer_win.json',
                width: IZISizeUtil.setSizeWithWidth(percent: .25),
                height: IZISizeUtil.setSizeWithWidth(percent: .25),
              ),
            )
          else
            const SizedBox(),
          Text(
            player.result ?? '',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w900,
                color: ColorResources.WHITE,
                fontFamily: 'Filson'),
          ),
          ContainerResult(
            height: IZISizeUtil.setSizeWithWidth(percent: .22),
            title: 'result_Page_2'.tr,
            numberAnswer: player.correctAnswer,
            icon: Icons.check,
            colorBackground: ColorResources.GREEN_BG,
            boderColor: ColorResources.GREEN_BD,
          ),
          ContainerResult(
            height: IZISizeUtil.setSizeWithWidth(percent: .22),
            title: 'result_Page_3'.tr,
            numberAnswer: player.wrongAnswer,
            icon: Icons.close,
            colorBackground: ColorResources.ORANGE_BG,
            boderColor: ColorResources.ORANGE_BD,
          ),
          SizedBox(
            height: IZISizeUtil.setSize(percent: 0.01),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GridViewContainer(
                onTap: () {
                  controller.isScreenExited = true;
                  controller.animationController.dispose();
                  Get.offAllNamed(controller.route);

                },
                color: ColorResources.BG,
                borderColor: ColorResources.BG_BT,
                width: IZISizeUtil.setSizeWithWidth(percent: .3),
                height: IZISizeUtil.setSizeWithWidth(percent: .17),
                titleText: 'exit'.tr,
              ),
              GridViewContainer(
                onTap: () {
                  controller.resetGame();
                  controller.onInit();
                  Get.toNamed(MainRouters.MULTIPLAYER);

                  if (Get.isRegistered<SoundController>()) {
                    controller.sound.playPlaySound();
                    controller.sound.pauseBackgroundSound();
                  }
                },
                color: ColorResources.BG,
                borderColor: ColorResources.BG_BT,
                width: IZISizeUtil.setSizeWithWidth(percent: .3),
                height: IZISizeUtil.setSizeWithWidth(percent: .17),
                titleText: 'rematch'.tr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
