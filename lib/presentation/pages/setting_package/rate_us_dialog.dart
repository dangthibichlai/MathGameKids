import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/core/export/core_export.dart';

class RateUsDialog extends StatefulWidget {
  const RateUsDialog({super.key, required this.callBack});

  final Function callBack;

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  ///
  /// Declare the data.
  final List<String> _rateUsList = [
    ImagesPath.rateIc1Star,
    ImagesPath.rateIc2Star,
    ImagesPath.rateIc3Star,
    ImagesPath.rateIc4Star,
    ImagesPath.rateIc5Star,
  ];
  int? _currentRate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: IZISizeUtil.setEdgeInsetsSymmetric(
            horizontal: IZISizeUtil.setSizeWithWidth(percent: .15),
          ),
          width: IZISizeUtil.getMaxWidth(),
          decoration: BoxDecoration(
            color: ColorResources.BROW,
            borderRadius:
                IZISizeUtil.setBorderRadiusAll(radius: IZISizeUtil.RADIUS_6X),
          ),
          child: Column(
            children: [
              IZIImage(
                _currentRate == null
                    ? ImagesPath.rateIc5Star
                    : _rateUsList[_currentRate! - 1], //
                width: IZISizeUtil.setSizeWithWidth(percent: .4),
              ),
              Padding(
                padding: IZISizeUtil.setEdgeInsetsSymmetric(
                    horizontal: IZISizeUtil.SPACE_5X),
                child: Text(
                  'rate'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorResources.WHITE,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'rate_1'.tr,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF00B2FF),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: IZISizeUtil.setEdgeInsetsOnly(
                      top: IZISizeUtil.SPACE_3X,
                      left: IZISizeUtil.SPACE_1X,
                    ),
                    child: IZIImage(
                      ImagesPath.rateIcArrowRight,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: IZISizeUtil.setEdgeInsetsOnly(
                  top: IZISizeUtil.SPACE_2X,
                  bottom: IZISizeUtil.SPACE_5X,
                ),
                child: RatingBar.builder(
                  unratedColor: ColorResources.WHITE,
                  glowColor: Colors.transparent,
                  initialRating: 5,
                  minRating: 1,
                  itemSize: 35,
                  maxRating: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) {
                    return IZIImage(
                      (_currentRate != null && _currentRate! - 1 >= index)
                          ? ImagesPath.rateIcSelectStar
                          : ImagesPath.rateIcUnSelectStar,
                      width: IZISizeUtil.setSize(percent: 0.01),
                      colorIconsSvg: ((_currentRate != null &&
                                  _currentRate! - 1 >= index) ||
                              index == 4)
                          ? ColorResources.YELLOW
                          : ColorResources.WHITE,
                    );
                  },
                  onRatingUpdate: (rating) {
                    _currentRate = IZINumber.parseInt(rating);
                    setState(() {});
                  },
                ),
              ),
              IZIButton(
                margin: IZISizeUtil.setEdgeInsetsOnly(
                  left: IZISizeUtil.SPACE_4X,
                  right: IZISizeUtil.SPACE_4X,
                  bottom: IZISizeUtil.SPACE_6X,
                ),
                colorBG: ColorResources.BACKGROUND,
                height: IZISizeUtil.setSizeWithWidth(percent: .1),
                fontSizedLabel: 14.sp,
                label: 'setting_5'.tr,
                onTap: () {
                  Get.back();
                  widget.callBack(_currentRate);
                },
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: IZISizeUtil.setEdgeInsetsOnly(top: IZISizeUtil.SPACE_2X),
            width: IZISizeUtil.setSize(percent: .04),
            height: IZISizeUtil.setSize(percent: .04),
            decoration: BoxDecoration(
              color: ColorResources.WHITE.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: ColorResources.WHITE,
              ),
            ),
          ),
        )
      ],
    );
  }
}
