import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aigent_softwares/core/theme/app_colors.dart';

// Particle model
class _Particle {
  double x, y, speed, radius;
  _Particle(
      {required this.x,
      required this.y,
      required this.speed,
      required this.radius});
}

// Node model
class _Node {
  double baseX, baseY;
  double offsetX, offsetY;
  double phase;
  double radius;
  _Node({
    required this.baseX,
    required this.baseY,
    required this.offsetX,
    required this.offsetY,
    required this.phase,
    required this.radius,
  });
}

class AnimatedNeuralBackground extends StatefulWidget {
  const AnimatedNeuralBackground({super.key});

  @override
  State<AnimatedNeuralBackground> createState() =>
      _AnimatedNeuralBackgroundState();
}

class _AnimatedNeuralBackgroundState extends State<AnimatedNeuralBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Node> _nodes = [];
  final List<_Particle> _particles = [];
  final Random _random = Random();
  bool _initialized = false;
  Size _lastSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initData(Size size) {
    if (_initialized && _lastSize == size) return;
    _initialized = true;
    _lastSize = size;

    _nodes.clear();
    for (int i = 0; i < 50; i++) {
      _nodes.add(_Node(
        baseX: _random.nextDouble() * size.width,
        baseY: _random.nextDouble() * size.height,
        offsetX: 20 + _random.nextDouble() * 30,
        offsetY: 20 + _random.nextDouble() * 30,
        phase: _random.nextDouble() * 2 * pi,
        radius: 3.r + _random.nextDouble() * 3,
      ));
    }

    _particles.clear();
    for (int i = 0; i < 150; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble() * size.width,
        y: _random.nextDouble() * size.height,
        speed: 0.3 + _random.nextDouble() * 0.7,
        radius: 1.r,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          _initData(size);
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _NeuralPainter(
                  t: _controller.value,
                  nodes: _nodes,
                  particles: _particles,
                  size: size,
                ),
                size: size,
              );
            },
          );
        },
      ),
    );
  }
}

class _NeuralPainter extends CustomPainter {
  final double t;
  final List<_Node> nodes;
  final List<_Particle> particles;
  final Size size;

  _NeuralPainter({
    required this.t,
    required this.nodes,
    required this.particles,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final double time = t * 2 * pi;
    const double connectionDist = 150.0;

    // Compute node positions
    final List<Offset> positions = nodes.map((n) {
      final dx = n.offsetX * sin(time + n.phase);
      final dy = n.offsetY * cos(time + n.phase * 0.7);
      return Offset(
        (n.baseX + dx).clamp(0, canvasSize.width),
        (n.baseY + dy).clamp(0, canvasSize.height),
      );
    }).toList();

    // Draw connection lines
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        final dist = (positions[i] - positions[j]).distance;
        if (dist < connectionDist) {
          final opacity = (1 - dist / connectionDist).clamp(0.1, 0.6);
          final pulseOpacity = opacity * (0.6 + 0.4 * sin(time * 2 + i * 0.3));
          linePaint.color =
              AppColors.electricBlue.withOpacity(pulseOpacity.clamp(0.0, 1.0));
          canvas.drawLine(positions[i], positions[j], linePaint);
        }
      }
    }

    // Draw nodes
    final nodePaint = Paint()..style = PaintingStyle.fill;
    final glowPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < positions.length; i++) {
      final node = nodes[i];
      final pos = positions[i];

      // Glow
      glowPaint.color = AppColors.primaryPurple.withOpacity(0.15);
      canvas.drawCircle(pos, node.radius * 3, glowPaint);

      // Node
      nodePaint.color = AppColors.primaryPurple.withOpacity(0.85);
      canvas.drawCircle(pos, node.radius, nodePaint);

      // Bright center
      nodePaint.color = Colors.white.withOpacity(0.5);
      canvas.drawCircle(pos, node.radius * 0.4, nodePaint);
    }

    // Draw particles (upward drift)
    final particlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(0.5);

    for (final p in particles) {
      final newY = (p.y - p.speed * t * 200) % canvasSize.height;
      canvas.drawCircle(Offset(p.x, newY < 0 ? newY + canvasSize.height : newY),
          p.radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(_NeuralPainter old) => old.t != t;
}
