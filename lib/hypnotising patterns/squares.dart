import 'dart:math' as math;
import 'package:flutter/material.dart';

class HypnoSquares extends StatefulWidget {
  const HypnoSquares({super.key});

  @override
  HypnoSquaresState createState() => HypnoSquaresState();
}

class HypnoSquaresState extends State<HypnoSquares> with SingleTickerProviderStateMixin {
  double squareSize = 0.0;
  double squareGap = 10.0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        lowerBound: squareSize,
        upperBound: squareGap)
      ..repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: SquareWavePainter(controller.value),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SquareWavePainter extends CustomPainter {
  final double squareSize;
  var squarePaint = Paint();
  SquareWavePainter(this.squareSize) {
    squarePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = hypot(centerX, centerY);

    var currentSize = squareSize;
    while (currentSize < maxRadius) {
      canvas.drawRect(
        Rect.fromCenter(center: Offset(centerX, centerY), width: currentSize, height: currentSize),
        squarePaint,
      );
      currentSize += 10.0;
    }
  }

  @override
  bool shouldRepaint(SquareWavePainter oldDelegate) {
    return oldDelegate.squareSize != squareSize;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
