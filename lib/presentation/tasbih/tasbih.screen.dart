import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<ui.Image> loadImage(String path) async {
  final data = await rootBundle.load(path);
  final bytes = data.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  void playBeadSound() {
    _audioPlayer.play(AssetSource("sounds/bead_click.mp3"));
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ramadan App'), centerTitle: true),
      body: FutureBuilder<ui.Image>(
        future: loadImage("assets/images/beadblackmarble.png"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    size: const Size(500, 200),
                    painter: QuadraticBezierPainter(
                      snapshot.data!,
                      _controller.value,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  playBeadSound();
                  _controller.forward(from: 0);
                },
                child: const Text("Move Beads"),
              ),
            ],
          );
        },
      ),
    );
  }
}

class QuadraticBezierPainter extends CustomPainter {
  final ui.Image image;
  final double progress;

  QuadraticBezierPainter(this.image, this.progress);

  // Compute point on quadratic bezier curve
  Offset quadraticBezierPoint(Offset p0, Offset p1, Offset p2, double t) {
    double x =
        (1 - t) * (1 - t) * p0.dx + 2 * (1 - t) * t * p1.dx + t * t * p2.dx;
    double y =
        (1 - t) * (1 - t) * p0.dy + 2 * (1 - t) * t * p1.dy + t * t * p2.dy;
    return Offset(x, y);
  }

  // Smooth easing
  double ease(double t) {
    return Curves.easeOut.transform(t);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Bezier control points
    final p0 = Offset(0, size.height / 2);
    final p1 = Offset(size.width / 2, -size.height / 6);
    final p2 = Offset(size.width, size.height / 16);

    // Draw main curve
    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);

    const imageSize = 40.0;
    final imagePaint = Paint();

    // ===== P0 → P1 beads =====
    final List<double> p0ToP1Base = List.generate(4, (i) => 0.0 + i * 0.1);

    for (int i = 0; i < p0ToP1Base.length; i++) {
      double baseT = p0ToP1Base[i];
      double animatedT;

      if (i == p0ToP1Base.length - 1) {
        // Last bead moves forward along the curve
        animatedT = (baseT + ease(progress) * 0.65).clamp(0.0, 0.67);
      } else {
        // Other beads: slight micro-movement
        double offsetFactor = 0.05 + i * 0.02;
        animatedT = (baseT + ease(progress) * offsetFactor).clamp(0.0, 0.30);
      }

      Offset pos = quadraticBezierPoint(p0, p1, p2, animatedT);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromCenter(center: pos, width: imageSize, height: imageSize),
        imagePaint,
      );
    }

    // ===== P2 → P3 beads =====
    final List<double> p2ToP3Base = List.generate(4, (i) => 0.65 + i * 0.11);

    for (int i = 0; i < p2ToP3Base.length; i++) {
      double baseT = p2ToP3Base[i];
      double offsetFactor = 0.02 + i * 0.01;
      double animatedT =
          (baseT + ease(progress) * offsetFactor).clamp(0.65, 1.0);

      Offset pos = quadraticBezierPoint(p0, p1, p2, animatedT);

      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromCenter(center: pos, width: imageSize, height: imageSize),
        imagePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant QuadraticBezierPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class BezierAnimation extends StatefulWidget {
  final ui.Image image;

  const BezierAnimation({super.key, required this.image});

  @override
  _BezierAnimationState createState() => _BezierAnimationState();
}

class _BezierAnimationState extends State<BezierAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // loop animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        size: Size(300, 200),
        painter: QuadraticBezierPainter(widget.image, _controller.value),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
