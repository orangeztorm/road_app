import 'package:flutter/material.dart';

class RotatingImage extends StatefulWidget {
  final Widget child;
  const RotatingImage({
    super.key,
    required this.child,
  });
  @override
  // ignore: library_private_types_in_public_api
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Duration of rotation animation
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.1415926535897932,
          child: widget.child, // Replace with your image
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
