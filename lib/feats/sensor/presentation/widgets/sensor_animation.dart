import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_animation/feats/sensor/presentation/provider/sensor_provider.dart';

class Layer {
  Layer({
    Key? key,
    required this.sensitivity,
    this.offset,
    this.image,
    this.imageFit = BoxFit.cover,
    this.preventCrop = false,
    this.imageHeight,
    this.imageWidth,
    this.imageBlurValue,
    this.imageDarkenValue,
    this.opacity,
    this.child,
  }) : super();

  final double sensitivity;

  final Offset? offset;

  final ImageProvider<Object>? image;

  final BoxFit imageFit;

  final bool preventCrop;
  final double? imageHeight;
  final double? imageWidth;
  double? imageBlurValue;

  double? imageDarkenValue;

  double? opacity;

  final Widget? child;

  Widget _build(context, int animationDuration, double maxSensitivity, double top, double bottom, double right,
          double left) =>
      AnimatedPositioned(
        duration: Duration(milliseconds: animationDuration),
        top: (preventCrop
                ? (top - maxSensitivity) * sensitivity
                : (top) * sensitivity +
                    (MediaQuery.of(context).size.height - (imageHeight ?? MediaQuery.of(context).size.height)) / 2) +
            ((offset?.dy ?? 0) / 2),
        bottom: (preventCrop
                ? (bottom - maxSensitivity) * sensitivity
                : (bottom) * sensitivity +
                    (MediaQuery.of(context).size.height - (imageHeight ?? MediaQuery.of(context).size.height)) / 2) -
            ((offset?.dy ?? 0) / 2),
        right: (preventCrop
                ? (right - maxSensitivity) * sensitivity
                : (right) * sensitivity +
                    (MediaQuery.of(context).size.width - (imageWidth ?? MediaQuery.of(context).size.width)) / 2) -
            ((offset?.dx ?? 0) / 2),
        left: (preventCrop
                ? (left - maxSensitivity) * sensitivity
                : (left) * sensitivity +
                    (MediaQuery.of(context).size.width - (imageWidth ?? MediaQuery.of(context).size.width)) / 2) +
            ((offset?.dx ?? 0) / 2),
        child: Opacity(
          opacity: opacity ?? 1,
          child: Container(
            height: imageHeight,
            width: imageWidth,
            decoration: BoxDecoration(
              image: image != null
                  ? DecorationImage(
                      image: image!,
                      fit: imageFit,
                    )
                  : null,
            ),
            child: Stack(
              children: [
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: imageBlurValue ?? 0, sigmaY: imageBlurValue ?? 0),
                    child: Container(
                      height: imageHeight,
                      width: imageWidth,
                      decoration: BoxDecoration(color: Colors.black.withValues(alpha: imageDarkenValue ?? 0.0)),
                    ),
                  ),
                ),
                child ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
}

class _SensorAnimation extends StatefulWidget {
  const _SensorAnimation({
    this.sensor = SensorType.accelerometer,
    required this.layers,
    this.animationDuration = 300,
    this.child,
  });

  final SensorType sensor;
  final List<Layer> layers;
  final int animationDuration;
  final Widget? child;

  @override
  State<_SensorAnimation> createState() => _SensorAnimationState();
}

class _SensorAnimationState extends State<_SensorAnimation> {
  late SensorProvider provider;
  @override
  void initState() {
    provider = context.read<SensorProvider>();
    provider.init(widget.sensor);
    super.initState();
  }

  @override
  void dispose() {
    provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = context.watch<SensorProvider>();
    return Stack(
      children: [
        Stack(
          children: widget.layers
              .map((layer) => layer._build(
                    context,
                    widget.animationDuration,
                    10,
                    provider.top,
                    provider.bottom,
                    provider.right,
                    provider.left,
                  ))
              .toList(),
        ),
        widget.child ?? Container(),
      ],
    );
  }
}

class SensorAnimation extends StatelessWidget {
  const SensorAnimation({
    super.key,
    this.sensor = SensorType.accelerometer,
    required this.layers,
    this.animationDuration = 300,
    this.child,
  });

  final SensorType sensor;
  final List<Layer> layers;
  final int animationDuration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SensorProvider(),
      child: _SensorAnimation(
        sensor: sensor,
        layers: layers,
        animationDuration: animationDuration,
        child: child,
      ),
    );
  }
}
