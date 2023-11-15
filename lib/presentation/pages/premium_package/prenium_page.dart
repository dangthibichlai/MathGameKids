import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/config/routes/route_path/main_routh.dart';
import 'package:template/core/export/core_export.dart';
import 'package:template/presentation/controller/package_description_component/package_button_widget.dart';
import 'package:template/presentation/pages/premium_package/close_button_widget.dart';
import 'package:template/presentation/pages/premium_package/package_card.dart';
import 'package:template/presentation/pages/premium_package/prenium_controller.dart';

class PreniumPage extends GetView<PreniumController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: IZISizeUtil.getMaxWidth(),
        height: IZISizeUtil.getMaxHeight(),
        decoration: BoxDecoration(
          gradient: CommonHelper.backGroundScaffold,
        ),
        // ignore: sort_child_properties_last
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return Center(
                  child: LoadingApp(titleLoading: 'buy_Package_11'.tr));
            }
            return Stack(
              children: [
                Positioned.fill(
                  child: IZIImage(ImagesPath.bg_premium),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _textHeader(),
                      _listView(),
                      _package(context),
                      PackageButtonWidget(
                        width: IZISizeUtil.setSizeWithWidth(percent: 0.9),
                        callBack: () {
                          CommonHelper.onTapHandler(callback: () {
                            controller.continueLoginApp();
                          });
                        },
                      ),
                      _bottomTitle(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Obx(
        () {
          if (controller.isLoading.value) {
            return const SizedBox();
          }
          return CloseButtonWidget(
            callBack: () {
              Get.offNamed(MainRouters.HOME);
            },
          );
        },
      ),
    );
  }

  Widget _textHeader() {
    return SizedBox(
      width: IZISizeUtil.setSizeWithWidth(percent: .8),
      height: IZISizeUtil.setSize(percent: .14),
      child: Column(
        // chỉnh column nằn dưới
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'home_Page_1_1'.tr,
                        style: GoogleFonts.nunitoSans(
                            // nét chữ đậm hơn
                            decorationThickness: 20,
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            color: ColorResources.MATHPRIMARY),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 20), // Khoảng cách 5 đơn vị
                      ),
                      TextSpan(
                        text: 'home_Page_1_2'.tr,
                        style: GoogleFonts.nunitoSans(
                            decorationThickness: 20,
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            color: ColorResources.BLACK),
                      ),
                    ],
                  ),
                ),
                // Text 'PRO' nền đen bo gọc
                Container(
                  margin:
                      IZISizeUtil.setEdgeInsetsOnly(left: IZISizeUtil.SPACE_2X),
                  padding: IZISizeUtil.setEdgeInsetsOnly(
                      left: IZISizeUtil.RADIUS_5X,
                      right: IZISizeUtil.RADIUS_5X,
                      top: IZISizeUtil.RADIUS_1X,
                      bottom: IZISizeUtil.RADIUS_1X),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(IZISizeUtil.RADIUS_4X),
                    color: const Color(0xFF000000),
                  ),
                  child: Text(
                    'pro'.tr,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                      //height: 0.07,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: IZISizeUtil.SPACE_1X),
          FittedBox(
            child: Text(
              'sub_text_premium'.tr,
              maxLines: 1,
              style: const TextStyle(
                color: ColorResources.T_PREMIUM,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,

                //height: 0.07,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listView() {
    return CarouselSlider.builder(
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: itemBuilder(context, index),
        );
      },
      itemCount: controller.listViews.length,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        height: IZISizeUtil.setSize(percent: .14),
        viewportFraction: 0.33,
        clipBehavior: Clip.none,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        pageSnapping: false,
      ),
    );
  }

  // return SizedBox(
  //   height: IZISizeUtil.setSize(percent: .14),
  //   width: IZISizeUtil.getMaxWidth(),
  //   child: ScrollConfiguration(
  //     behavior: const ScrollBehavior().copyWith(overscroll: false),
  //     child: ListView.separated(
  //         controller: controller.controller,
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         padding: IZISizeUtil.setEdgeInsetsOnly(
  //             left: IZISizeUtil.SPACE_1X, right: IZISizeUtil.SPACE_2X),
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: itemBuilder,
  //         separatorBuilder: (context, index) =>
  //             const SizedBox(width: IZISizeUtil.SPACE_2X),
  //         itemCount: controller.listViews.length),
  //   ),
  // );

  Widget _bottomTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            log('goToPrivacyPolicy');
            CommonHelper.onTapHandler(callback: () {
              controller.goToPrivacyPolicy();
            });
          },
          child: Container(
            width: IZISizeUtil.setSizeWithWidth(percent: .3),
            height: IZISizeUtil.setSizeWithWidth(percent: .15),
            padding: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_3X),
            child: Text(
              'text_bottom_pre_001'.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 14.58,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                //height: 0.07,
              ),
            ),
          ),
        ),
        // const SizedBox(width: 34.38),
        InkWell(
          onTap: () {
            log('goToTermOfUser');
            CommonHelper.onTapHandler(callback: () {
              controller.goToTermOfUser();
            });
          },
          child: Container(
            width: IZISizeUtil.setSizeWithWidth(percent: .3),
            height: IZISizeUtil.setSizeWithWidth(percent: .15),
            padding: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_3X),
            child: Text(
              'text_bottom_pre_002'.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 14.58,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                //gach chan text style decoration
                decoration: TextDecoration.underline,
                // height: 0.07,
              ),
            ),
          ),
        ),
        //const SizedBox(width: 34.38),
        GestureDetector(
          onTap: () {
            CommonHelper.onTapHandler(callback: () {
              controller.restorePurchase();
            });
          },
          child: Container(
            height: IZISizeUtil.setSizeWithWidth(percent: .15),
            width: IZISizeUtil.setSizeWithWidth(percent: .3),
            padding: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_3X),
            child: Text(
              'text_bottom_pre_003'.tr,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 14.58,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                // height: 0.07,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    final Map<String, dynamic> item = controller.listViews[index];
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: IZIImage(
            item['image'], // Đường dẫn hình ảnh
            width: IZISizeUtil.setSizeWithWidth(percent: .3),
            height: IZISizeUtil.setSizeWithWidth(percent: .3),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: IZISizeUtil.setSizeWithWidth(percent: .3),
            height: IZISizeUtil.setSize(percent: 0.1),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.01, 1.00),
                end: Alignment(-0.01, -1),
                colors: [Color(0xFF000905), Color(0x00D9D9D9)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: IZISizeUtil.setSize(percent: .003),
          left: IZISizeUtil.setSizeWithWidth(percent: .01),
          child: SizedBox(
            width: IZISizeUtil.setSizeWithWidth(percent: .28),
            height: IZISizeUtil.setSize(percent: 0.04),
            child: AutoSizeText(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                //height: 0.08,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Package.
  ///
  Widget _package(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          padding: IZISizeUtil.setEdgeInsetsOnly(
              bottom: IZISizeUtil.SPACE_2X,
              top: IZISizeUtil.SPACE_2X,
              left: IZISizeUtil.SPACE_4X,
              right: IZISizeUtil.SPACE_3X),
          itemCount: controller.productsList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Obx(
              () => PackageCard(
                data: controller.productsList[index],
                callBack: () {
                  controller.onChangePackage(index: index);
                },
                currentIndex: controller.currentIndexPackage.value,
                index: index,
                originalMonthlyPrice: controller.productsList[index].id
                            .compareTo(IdSubscription.monthlyId) ==
                        0
                    ? controller.originalMonthlyPrice
                    : null,
              ),
            );
          });
    });
  }
}
