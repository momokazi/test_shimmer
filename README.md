# reusable_shimmer

A reusable shimmer and skeleton package for Flutter that makes loading states effortless.

## Features

*   **Ease of Use**: Convert any widget to a shimmer placeholder with `.toShimmer()`.
*   **Ready-made Components**: Use `Skeleton` for manual placeholders (circles, rectangles).
*   **Customizable**: Configure colors, duration, and direction globally or locally.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  reusable_shimmer: ^1.0.0
```

## Usage

### Using the Extension (Recommended)

Wrap your actual content with `.toShimmer(loading: isLoading)`.

```dart
import 'package:reusable_shimmer/reusable_shimmer.dart';

Text("My Content").toShimmer(
  loading: isLoading,
  width: 100,
  height: 20,
);
```

### Using Skeleton Widget

```dart
Skeleton(
  width: 50,
  height: 50,
  decoration: BoxDecoration(shape: BoxShape.circle),
);
```

### Configuration

You can pass a custom `ShimmerConfig`:

```dart
final myConfig = ShimmerConfig(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
);

Skeleton(config: myConfig, ...);
```
