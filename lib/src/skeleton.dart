import 'package:flutter/material.dart';
import 'shimmer_config.dart';
import 'shimmer_effect.dart';

/// A generic skeleton widget that displays a shimmering placeholder.
class Skeleton extends StatelessWidget {
  /// The width of the skeleton. If null, it will default to the child's width (if any) or be unconstrained.
  final double? width;

  /// The height of the skeleton.
  final double? height;

  /// Margin around the skeleton.
  final EdgeInsetsGeometry? margin;

  /// Padding inside the skeleton.
  final EdgeInsetsGeometry? padding;

  /// Decoration for the skeleton container (e.g. borderRadius, shape).
  ///
  /// Defaults to a rounded rectangle with the base color from [config].
  final BoxDecoration? decoration;

  /// Configuration for the shimmer effect.
  final ShimmerConfig? config;

  /// Creates a skeleton placeholder.
  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // If no decoration is provided, default to a rounded rectangle.
    final BoxDecoration boxDecoration =
        decoration ??
        BoxDecoration(
          color: (config ?? const ShimmerConfig()).baseColor,
          borderRadius: BorderRadius.circular(4),
        );

    // Ensure the decoration has the base color if not specified
    final effectiveDecoration = boxDecoration.copyWith(
      color: boxDecoration.color ?? (config ?? const ShimmerConfig()).baseColor,
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: ShimmerEffect(
        config: config ?? const ShimmerConfig(),
        child: DecoratedBox(
          decoration: effectiveDecoration,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

/// Extension to easily add shimmer/skeleton state to any widget.
extension ReusableShimmerExtension on Widget {
  /// Wraps this widget with a shimmer loading state.
  ///
  /// If [loading] is true, shows a [Skeleton] with the specified properties.
  /// If [loading] is false, shows the original widget.
  Widget toShimmer({
    required bool loading,
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    ShimmerConfig? config,
  }) {
    if (!loading) {
      // If visible, we usually still want the margin to apply so layout doesn't jump?
      // The user's example Usage:
      // Text(...).withShimmerAi(loading: false, margin: ...)
      // If we rely on the original widget to have margin, we might need a Container wrapper.
      if (margin != null) {
        return Container(margin: margin, child: this);
      }
      return this;
    }

    return Skeleton(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration,
      config: config,
    );
  }
}
