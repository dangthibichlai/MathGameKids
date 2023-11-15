import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';

import '../../core/utils/color_resources.dart';

class ButtonAnimated extends StatefulWidget {
  const ButtonAnimated({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function onTap;

  @override
  State<ButtonAnimated> createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward(from: 0);
      }
    });

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animationController.forward();
      },
      child: Container(
        width: IZISizeUtil.setSizeWithWidth(percent: .4),
        height: IZISizeUtil.setSizeWithWidth(percent: .18),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 20,
              color: Colors.blue,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Container(
                width: IZISizeUtil.setSizeWithWidth(percent: .4),
                height: IZISizeUtil.setSizeWithWidth(percent: .2),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 10,
                      color: Colors.blue,
                    ),
                  ],
                  gradient: SweepGradient(
                    startAngle: 4,
                    colors: const [
                      Color.fromARGB(255, 104, 175, 233),
                      Color.fromARGB(255, 174, 212, 243),
                    ],
                    transform: GradientRotation(_animationController.value * 6),
                  ),
                ),
              ),
              Padding(
                padding: IZISizeUtil.setEdgeInsetsAll(
                  IZISizeUtil.setSizeWithWidth(percent: .01),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.BACKGROUND,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.text,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorResources.WHITE,
                        fontFamily: 'Filson'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
