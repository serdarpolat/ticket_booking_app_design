import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgressBar extends StatefulWidget {
  final double startAngle;
  final double trackWidth;
  final Color trackColor;
  final double trackPercent;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final Widget child;

  RadialProgressBar({
    this.startAngle = 0.0,
    this.trackWidth = 1.0,
    this.trackColor,
    this.trackPercent = 0.0,
    this.progressWidth = 3.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.outerPadding = const EdgeInsets.all(0.0),
    this.innerPadding = const EdgeInsets.all(0.0),
    this.child,
  });

  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.outerPadding,
      child: CustomPaint(
        foregroundPainter: RadialSeekBarPainter(
          startAngle: widget.startAngle,
          trackWidth: widget.trackWidth,
          trackColor: widget.trackColor,
          trackPercent: widget.trackPercent,
          progressWidth: widget.progressWidth,
          progressColor: widget.progressColor,
          progressPercent: widget.progressPercent,
        ),
        child: widget.child,
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final double startAngle;
  final double trackWidth;
  final Paint trackPaint;
  final double trackPercent;
  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;

  RadialSeekBarPainter({
    @required this.startAngle,
    @required this.trackWidth,
    @required trackColor,
    @required this.trackPercent,
    @required this.progressWidth,
    @required progressColor,
    @required this.progressPercent,
  })  : trackPaint = new Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = new Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    Size constrainedSize = new Size(
      size.width,
      size.height,
    );

    final center = new Offset(size.width / 2, size.height / 2);
    //final radius = min(size.width+10, size.height+10) / 2;
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    final trackAngle = 2 * pi * trackPercent;

    // Paint track
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle * (0.0174532925),
      trackAngle,
      false,
      trackPaint,
    );

    final progressAngle = 2 * pi * progressPercent;

    // Paint progress
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle * (0.0174532925),
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
