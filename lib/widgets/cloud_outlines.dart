import 'package:flutter/material.dart';
import 'dart:math' as math;

class CloudOutlines extends StatefulWidget {
  final bool isDark;
  final int cloudCount;
  final double cloudSpeed;

  const CloudOutlines({
    super.key,
    required this.isDark,
    this.cloudCount = 9,
    this.cloudSpeed = 1.0,
  });

  @override
  State<CloudOutlines> createState() => _CloudOutlinesState();
}

class _CloudOutlinesState extends State<CloudOutlines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_CloudData> clouds;
  late List<_CloudShape> cloudShapes;
  static const double minCloudSize = 40.0;
  static const double maxCloudSize = 128.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 65))
          ..repeat();
    final random = math.Random();
    cloudShapes = [_CloudShape.cloud1, _CloudShape.cloud2, _CloudShape.cloud3];

    clouds = [];
    final minDist = 0.07;
    double maxTry = 120;
    while (clouds.length < widget.cloudCount && maxTry > 0) {
      final candidateX = random.nextDouble() * 1.10;
      if (clouds.every((c) => (c.startX - candidateX).abs() > minDist)) {
        final cShape = cloudShapes[random.nextInt(cloudShapes.length)];
        final color = [
          Colors.grey.shade300,
          Color(0xFFD6D8DC),
          Colors.grey.shade400
        ][random.nextInt(3)];

        final cloudSize = minCloudSize +
            random.nextDouble() * (maxCloudSize - minCloudSize);

        clouds.add(
          _CloudData(
            startX: candidateX,
            size: cloudSize,
            y: 0.10 + 0.82 * random.nextDouble(),
            swayAmp: 0.03 + random.nextDouble() * 0.04,
            swayPeriod: 18.0 + random.nextDouble() * 17,
            driftSpeed: (0.10 + random.nextDouble() * 0.20) * widget.cloudSpeed,
            opacity: 0.22 + random.nextDouble() * 0.17,
            shape: cShape,
            color: color,
            phase: random.nextDouble() * math.pi * 2,
          ),
        );
      }
      maxTry--;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDark) return const SizedBox.shrink();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: clouds.map((cloud) {
            final t = _controller.value;
            double driftX = (cloud.startX + t * cloud.driftSpeed) % 1.10;
            driftX += math.sin(t * 2 * math.pi / cloud.swayPeriod + cloud.phase) *
                cloud.swayAmp;
            return Positioned(
              left: width * driftX - cloud.size / 2,
              top: height * cloud.y,
              child: Opacity(
                opacity: cloud.opacity,
                child: _renderCloud(cloud),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _renderCloud(_CloudData data) {
    switch (data.shape) {
      case _CloudShape.cloud1:
        return Icon(Icons.cloud_outlined, size: data.size, color: data.color);
      case _CloudShape.cloud2:
        return Transform.rotate(
          angle: math.pi / 21,
          child: Icon(Icons.cloud_queue, size: data.size, color: data.color),
        );
      case _CloudShape.cloud3:
        return Icon(Icons.filter_drama, size: data.size * 0.89, color: data.color);
    }
  }
}

enum _CloudShape { cloud1, cloud2, cloud3 }

class _CloudData {
  final double startX, size, y, swayAmp, swayPeriod, driftSpeed, opacity, phase;
  final _CloudShape shape;
  final Color color;

  _CloudData({
    required this.startX,
    required this.size,
    required this.y,
    required this.swayAmp,
    required this.swayPeriod,
    required this.driftSpeed,
    required this.opacity,
    required this.shape,
    required this.color,
    required this.phase,
  });
}
