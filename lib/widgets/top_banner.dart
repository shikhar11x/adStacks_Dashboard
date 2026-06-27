import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

/// The "Top Rating Project" hero banner — gradient background, eyebrow tag,
/// heading, description, CTA button, and decorative geometric shapes.
class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: AppGradients.bannerGradient,
        borderRadius: BorderRadius.circular(AppDims.cardRadius),
      ),
      child: Stack(
        children: [
          // Decorative shapes — hidden on very small screens to avoid clutter.
          if (!isMobile)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 220,
                child: _DecorativeShapes(),
              ),
            ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(AppDims.pillRadius),
                  ),
                  child: Text(
                    'ETHEREUM 2.0',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Top Rating\nProject',
                  style: AppTextStyles.h1.copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Trending project and high rating\nproject created by team.',
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDims.pillRadius),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppDims.pillRadius),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Text(
                        'Learn More.',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A small cluster of geometric primitives (sphere, cube, cone) used purely
/// as decoration on the banner — built from shapes, not an external image.
class _DecorativeShapes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 10,
          top: 30,
          child: _Sphere(size: 70, color: Colors.black.withValues(alpha: 0.35)),
        ),
        Positioned(
          right: 30,
          top: 10,
          child: Transform.rotate(
            angle: -math.pi / 10,
            child: _Cube(size: 64),
          ),
        ),
        Positioned(
          left: 50,
          bottom: 20,
          child: _Cone(size: 56),
        ),
        Positioned(
          right: 10,
          bottom: 50,
          child: _Sphere(size: 36, color: Colors.white.withValues(alpha: 0.55)),
        ),
      ],
    );
  }
}

class _Sphere extends StatelessWidget {
  const _Sphere({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.3),
          radius: 1,
          colors: [
            Color.lerp(color, Colors.white, 0.5)!,
            color,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}

class _Cube extends StatelessWidget {
  const _Cube({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8C2F0), Color(0xFFB89BE0)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}

class _Cone extends StatelessWidget {
  const _Cone({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ConePainter(),
    );
  }
}

class _ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF8FE3D8), Color(0xFF4FB3C9)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.2), 6, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}