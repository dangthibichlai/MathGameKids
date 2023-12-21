import 'package:flutter/material.dart';
import 'package:template/core/base_widget/izi_image.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/images_path.dart';

class GentleShakeImage extends StatefulWidget {
  final double? width;
  final double? height;
  final double? widthImage;
  final double? heightImage;
  final String? image;
  final int? miliAnimation;
  final double? begin;
  final double? end;

  // ignore: prefer_const_constructors_in_immutables
  GentleShakeImage({
    Key? key,
    this.width,
    this.height,
    this.image,
    this.miliAnimation,
    this.widthImage,
    this.heightImage,
    this.begin,
    this.end,
  }) : super(key: key);

  @override
  _GentleShakeImageState createState() => _GentleShakeImageState();
}

class _GentleShakeImageState extends State<GentleShakeImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(
          milliseconds: widget.miliAnimation ??
              3000), // Increase duration for slower shake
      vsync: this,
    );

    _shakeAnimation =
        Tween<double>(begin: widget.begin ?? -0.1, end: widget.end ?? 0.1)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve:
            Curves.easeInOut, // Use a smoother curve for a gentle wave effect
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _shakeAnimation.value,
          child: child,
        );
      },
      child: SizedBox(
        width: widget.width ??
            IZISizeUtil.setSizeWithWidth(
                percent: .2), // Adjust the size as needed
        height: widget.height ??
            IZISizeUtil.setSizeWithWidth(
                percent: .2), // Adjust the size as needed
        child: IZIImage(
          widget.image ?? ImagesPath.homeImage,
          fit: BoxFit.contain,
          width: widget.widthImage ?? IZISizeUtil.setSizeWithWidth(percent: .2),
          height:
              widget.heightImage ?? IZISizeUtil.setSizeWithWidth(percent: .2),
        ),
      ),
    );
  }
}



// Using GentleShakeImage in another widget
// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GentleShakeImage(),
//       ),
//     );
//   }
// }
