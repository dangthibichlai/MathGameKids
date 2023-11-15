import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';

import '../../../core/export/core_export.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.callBack,
    required this.currentIndex,
    required this.index,
    required this.data,
    this.originalMonthlyPrice,
  });
  final Function callBack;
  final int currentIndex;
  final int index;
  final ProductDetails data;
  final double? originalMonthlyPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print(data.title);
        CommonHelper.onTapHandler(callback: () {
          callBack();
        });
      },
      child: Stack(
        children: [
          Container(
            padding: IZISizeUtil.setEdgeInsetsOnly(
              left: IZISizeUtil.setSizeWithWidth(percent: .1),
            ),
            margin: IZISizeUtil.setEdgeInsetsOnly(
              right: IZISizeUtil.SPACE_4X,
              left: IZISizeUtil.SPACE_4X,
              top: IZISizeUtil.SPACE_1X,
            ),
            height: IZISizeUtil.setSize(percent: .07),
            width: IZISizeUtil.setSizeWithWidth(percent: .99),
            decoration: currentIndex == index
                ? ShapeDecoration(
                    // shadows: const [
                    //   BoxShadow(
                    //     color: Color(0x1A000000),
                    //     offset: Offset(0, 3),
                    //     blurRadius: 6,
                    //     spreadRadius: 0,
                    //   ),
                    // ],
                    gradient: const LinearGradient(
                      begin: Alignment(1.00, -0.00),
                      end: Alignment(-1, 0),
                      colors: [Color(0xFFC6EFFF), Color(0xFFFEE8FF)],
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFF18E3FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                : null,
            child: Row(
              children: [
                if (currentIndex == index)
                  _checkedSpecial()
                else
                  Container(
                    width: 21,
                    height: 21,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(
                        side:
                            BorderSide(width: 1.50, color: ColorResources.GREY),
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.price}/${data.title.split(' ').first}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: currentIndex == index ? 20 : 16,
                            fontWeight: FontWeight.w700,
                            color: currentIndex == index
                                ? ColorResources.BLACK
                                : ColorResources.GREY,
                          ),
                    ),
                    SizedBox(
                      height: IZISizeUtil.setSize(percent: .01),
                    ),
                    if (originalMonthlyPrice != null)
                      Text(
                        NumberFormat.simpleCurrency(
                                locale: Get.deviceLocale!.toString())
                            .format(originalMonthlyPrice),
                        style: const TextStyle(
                          color: Color(0xFF646464),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                          // decorationStyle: TextDecoration.lineThrough,
                          height: 0.11,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (data.id.compareTo(IdSubscription.monthlyId) == 0 &&
              currentIndex == index)
            _specialFram(),
        ],
      ),
    );
  }

  Widget _checkedSpecial() {
    return SizedBox(
      width: 25,
      height: 40,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 10,
            child: Container(
              width: 21,
              height: 21,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(
                  side: BorderSide(color: Color(0xFF3AC4FF)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 3,
            top: 13,
            child: Container(
              width: 15,
              height: 15,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF3AC4FF), Color(0xD6FF60EF)],
                ),
                shape: OvalBorder(
                  side: BorderSide(color: Color(0xFF3AC4FF)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _specialFram() {
    return Positioned(
      right: 5,
      top: 0,
      child: SizedBox(
        width: 50,
        height: 50,
        child: IZIImage(ImagesPath.pre_special),
      ),
    );
  }
}
