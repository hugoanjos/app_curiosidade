import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  final Duration duration;
  final double begin;
  final double end;

  const LoadingIcon(
      {super.key,
      this.duration = const Duration(seconds: 1),
      this.begin = 0.85,
      this.end = 1});
  @override
  LoadingIconState createState() => LoadingIconState();
}

class LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: const Duration(milliseconds: 500));

    _animation =
        Tween(begin: widget.begin, end: widget.end).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
              scale: _animation.value,
              child: Image.asset(
                'assets/onion.png',
                height: 200,
              ));
        });
  }
}
