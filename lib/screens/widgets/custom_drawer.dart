import 'package:flutter/material.dart';
import 'dart:math' show pi;

class CustomDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget child;

  const CustomDrawer({
    super.key,
    required this.drawer,
    required this.child,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with TickerProviderStateMixin {
  late AnimationController _animationControllerForChild;
  late Animation<double> _rotationAnimationForChild;

  late AnimationController _animationControllerForDrawer;
  late Animation<double> _rotationAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _animationControllerForChild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rotationAnimationForChild = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_animationControllerForChild);

    _animationControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rotationAnimationForDrawer = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_animationControllerForDrawer);
  }

  @override
  void dispose() {
    _animationControllerForChild.dispose();
    _animationControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 1;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / maxDrag;
        _animationControllerForChild.value += delta;
        _animationControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details) {
        if (_animationControllerForChild.value < 0.5) {
          _animationControllerForChild.reverse();
          _animationControllerForDrawer.reverse();
        } else {
          _animationControllerForChild.forward();
          _animationControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _animationControllerForChild,
          _animationControllerForDrawer,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: const Color(0xFF1a1b26),
              ),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_animationControllerForChild.value * maxDrag)
                  ..rotateY(_rotationAnimationForChild.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(-screenWidth +
                      _animationControllerForDrawer.value * maxDrag)
                  ..rotateY(_rotationAnimationForDrawer.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
