import 'package:flutter/material.dart';

/// Configuration for the shimmer effect.
class ShimmerConfig {
  /// The base color of the shimmer.
  final Color baseColor;

  /// The highlight color of the shimmer.
  final Color highlightColor;

  /// The duration of the shimmer animation.
  final Duration period;

  /// The direction of the shimmer effect.
  final ShimmerDirection direction;

  const ShimmerConfig({
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
  });
}

/// Direction of the shimmer effect.
enum ShimmerDirection { ltr, rtl, ttb, btt }
