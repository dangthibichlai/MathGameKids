// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AnimateRolatePage extends StatefulWidget {
  const AnimateRolatePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _AnimateRolatePageState createState() => _AnimateRolatePageState();
}

class _AnimateRolatePageState extends State<AnimateRolatePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    _controller
      ..forward()
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 10.0).animate(_controller),
      child: widget.child,
    );
  }
}
