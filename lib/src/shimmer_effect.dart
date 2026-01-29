import 'package:flutter/material.dart';
import 'shimmer_config.dart';

/// A widget that paints a shimmering effect over its child.
class ShimmerEffect extends StatefulWidget {
  /// The widget to display underneath the shimmer effect.
  final Widget child;

  /// Configuration including colors, duration, and direction.
  final ShimmerConfig config;

  /// Creates a shimmer effect over a [child] widget.
  const ShimmerEffect({
    super.key,
    required this.child,
    this.config = const ShimmerConfig(),
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.period,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                widget.config.baseColor,
                widget.config.highlightColor,
                widget.config.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: _getBegin(bounds),
              end: _getEnd(bounds),
              transform: _SlidingGradientTransform(_controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }

  AlignmentGeometry _getBegin(Rect bounds) {
    switch (widget.config.direction) {
      case ShimmerDirection.ltr:
        return Alignment.topLeft;
      case ShimmerDirection.rtl:
        return Alignment.topRight;
      case ShimmerDirection.ttb:
        return Alignment.topCenter;
      case ShimmerDirection.btt:
        return Alignment.bottomCenter;
    }
  }

  AlignmentGeometry _getEnd(Rect bounds) {
    switch (widget.config.direction) {
      case ShimmerDirection.ltr:
        return Alignment
            .centerRight; // Intentionally limited to create sliding effect
      case ShimmerDirection.rtl:
        return Alignment.centerLeft;
      case ShimmerDirection.ttb:
        return Alignment.center;
      case ShimmerDirection.btt:
        return Alignment.topCenter;
    }
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.percent);

  final double percent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    // Basic translation based on percentage
    // Depending on direction logic, we mostly just slide along X or Y.
    // Simplifying for Left-to-Right:

    // For standard linear gradient shimmer, we usually move the stops or the transform.
    // Moving the stops is easier if we just want a loop.
    // However, GradientTransform is more performant.

    // Let's assume standard -1.0 to 2.0 translation for the gradient window.
    // Actually, createShader is called every frame, so we can calculate offsets there?
    // But GradientTransform is cleaner.

    // Just a simple translation
    return Matrix4.translationValues(
      (percent * 2 - 1) * bounds.width,
      0.0,
      0.0,
    );
  }
}
