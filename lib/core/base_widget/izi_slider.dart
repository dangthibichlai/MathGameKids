import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

class IZISlider extends StatefulWidget {
  const IZISlider({
    Key? key,
    this.axis = Axis.horizontal,
    required this.data,
    this.margin,
    this.onTap,
  }) : super(key: key);
  final Axis? axis;
  final List<String> data;
  final EdgeInsetsGeometry? margin;
  final Function(int index)? onTap;

  @override
  _IZISliderState createState() => _IZISliderState();
}

class _IZISliderState extends State<IZISlider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  imageSlider(widget.data[index].toString(), index),
                ],
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              height: IZISizeUtil.setSize(percent: .2),
              autoPlay: true,
              enlargeCenterPage: true,
              scrollDirection: widget.axis!,
              onPageChanged: (index, value) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Container(
            margin: IZISizeUtil.setEdgeInsetsOnly(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ..._buildIndicator(
                  length: widget.data.length,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// image slider
  ///
  Widget imageSlider(String urlImage, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(index);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 20),
        ),
        child: ClipRRect(
          borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 20),
          child: IZIImage(
            urlImage,
            width: IZISizeUtil.setSize(percent: 1),
            height: IZISizeUtil.setSize(percent: 0.3),
          ),
        ),
      ),
    );
  }

  ///
  /// build list indicator
  ///
  List<Widget> _buildIndicator({required int length, required int currentIndex}) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  ///
  /// indicator
  ///
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: IZISizeUtil.setEdgeInsetsSymmetric(horizontal: IZISizeUtil.SPACE_HORIZONTAL_SCREEN),
      height: isActive ? IZISizeUtil.setSize(percent: 0.02) : IZISizeUtil.setSize(percent: 0.01),
      width: isActive ? IZISizeUtil.setSize(percent: 0.02) : IZISizeUtil.setSize(percent: 0.01),
      decoration: BoxDecoration(
        borderRadius: IZISizeUtil.setBorderRadiusAll(radius: 50),
        color: isActive ? ColorResources.RED : ColorResources.RED.withOpacity(.2),
      ),
    );
  }
}
