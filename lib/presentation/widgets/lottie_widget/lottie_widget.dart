
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget({
    super.key,
    required this.jsonPath,
    required this.width,
  });

  final String jsonPath;
  final double width;

  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Lottie.asset(
        widget.jsonPath,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..repeat();
        },
      ),
    );
  }
}
