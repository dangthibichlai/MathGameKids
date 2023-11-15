import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/base_widget/izi_app_bar.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';
import 'package:template/core/utils/images_path.dart';
import 'package:template/presentation/pages/home/home_controller.dart';
import 'package:template/presentation/widgets/animation_home.dart';
import 'package:template/presentation/widgets/controller/sound_controller.dart';
import 'package:template/presentation/widgets/home_component/gri_container.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Nếu đang ở trang chủ, hiển thị hộp thoại thoát ứng dụng
        return await showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: _diaologHome(context),
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        appBar: BaseAppBar(
          isPremium: true,
          leading: GestureDetector(
            onTap: () => Get.toNamed(MainRouters.SETTING),
            child: Container(
              padding: IZISizeUtil.setEdgeInsetsAll(IZISizeUtil.SPACE_2X),
              child: IZIImage(
                ImagesPath.settingIcon,
                width: IZISizeUtil.setSizeWithWidth(percent: .04),
                height: IZISizeUtil.setSizeWithWidth(percent: .08),
                colorIconsSvg: ColorResources.WHITE,
              ),
            ),
          ),
          subTitle: 'home_Page_1_1'.tr,
          title: 'home_Page_1_2'.tr,
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                _headerHome(context),
                _listOperation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerHome(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: IZISizeUtil.setEdgeInsetsOnly(
            top: IZISizeUtil.setSizeWithWidth(percent: .15),
          ),
          padding: IZISizeUtil.setEdgeInsetsOnly(
            left: IZISizeUtil.setSizeWithWidth(percent: .05),
          ),
          height: IZISizeUtil.setSizeWithWidth(percent: .35),
          width: IZISizeUtil.setSizeWithWidth(percent: .85),
          decoration: BoxDecoration(
            color: ColorResources.BLUE_MG,
            borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_5X),
            border: Border.all(
              color: ColorResources.BLUE_MG_2,
              width: 5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    'home_Page_2'.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                        color: ColorResources.WHITE,
                        fontFamily: 'Filson'),
                  ),
                ],
              ),
              SizedBox(
                width: IZISizeUtil.setSizeWithWidth(percent: .4),
                height: IZISizeUtil.setSize(percent: .08),
                child: Text(
                  'home_Page_3'.tr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorResources.WHITE,
                      fontFamily: 'Filson'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 2,
          // Sử dụng getX để lấy giá trị của biến controller trong HomeController
          child: GentleShakeImage(
            height: IZISizeUtil.setSize(percent: 0.2),
            width: IZISizeUtil.setSize(percent: 0.18),
            begin: -0.025,
            end: 0.025,
          ),
        ),
      ],
    );
  }

  Widget _listOperation() {
    return Padding(
      padding: IZISizeUtil.setEdgeInsetsOnly(
          top: IZISizeUtil.setSizeWithWidth(percent: .12),
          left: IZISizeUtil.setSizeWithWidth(percent: .07),
          right: IZISizeUtil.setSizeWithWidth(percent: .07)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: IZISizeUtil.SPACE_4X,
          mainAxisSpacing: IZISizeUtil.SPACE_3X,
          childAspectRatio: 1.9,
        ),
        itemCount: controller.listButton.length,
        itemBuilder: (context, index) {
          final item = controller.listButton[index];

          ///
          /// GridViewContainer nếu onTap rỗng sẽ chuyển đến trang được định nghĩa trong routerPage
          return GridViewContainer(
            onTap: () {
              if (Get.isRegistered<SoundController>()) {
                Get.find<SoundController>().playClickHomeSound();
              }
              Get.toNamed(item['routerPage']);
            },
            sizeIcon: IZISizeUtil.setSizeWithWidth(percent: .135),
            title: item['title'],
            color: item['color'],
            borderColor: item['borderColor'],
            routerPage: item['routerPage'],
          );
        },
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget _diaologHome(BuildContext context) {
  return Container(
    constraints: BoxConstraints(
      minHeight: IZISizeUtil.setSizeWithWidth(percent: .7),
    ),
    // height: IZISizeUtil.setSizeWithWidth(percent: .8),
    width: IZISizeUtil.getMaxWidth(),
    decoration: BoxDecoration(
      color: ColorResources.WHITE,
      borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_2X),
      border: Border.all(
        color: ColorResources.BD_DIAOLOG,
        width: 5,
      ),
    ),
    child: Padding(
      padding: IZISizeUtil.setEdgeInsetsOnly(
        top: IZISizeUtil.SPACE_5X,
        left: IZISizeUtil.SPACE_3X,
        right: IZISizeUtil.SPACE_3X,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  bottom: IZISizeUtil.SPACE_5X,
                  left: IZISizeUtil.SPACE_3X,
                  right: IZISizeUtil.SPACE_3X,
                ),
                child: AutoSizeText(
                  'home_Page_4'.tr,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorResources.BACKGROUND,
                      fontFamily: 'Filson'),
                  maxLines: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GridViewContainer(
                    onTap: () {
                      exit(0);
                    },
                    width: IZISizeUtil.setSizeWithWidth(percent: .3),
                    height: IZISizeUtil.setSizeWithWidth(percent: .24),
                    fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
                    titleText: 'YES',
                    color: ColorResources.ORANGE_BG,
                    borderColor: ColorResources.ORANGE_BD,
                  ),
                  GridViewContainer(
                    onTap: () {
                      Get.back();
                    },
                    width: IZISizeUtil.setSizeWithWidth(percent: .29),
                    height: IZISizeUtil.setSizeWithWidth(percent: .24),
                    titleText: 'NO',
                    fontSizedLabel: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
                    color: ColorResources.GREEN_BG,
                    borderColor: ColorResources.GREEN_BD,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
