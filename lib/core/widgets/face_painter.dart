import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final bool isFrontCamera;

  FacePainter({
    required this.faces,
    required this.imageSize,
    this.isFrontCamera = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print("check imagesize are $imageSize");
    final Paint paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;

    // Scale factors from image coordinates → widget coordinates
    final double scaleX = size.width / imageSize.width;
    final double scaleY = size.height / imageSize.height;

    for (final Face face in faces) {
      final Rect faceRect = face.boundingBox;

      // Scale the bounding box to widget size
      final double left = isFrontCamera
          ? size.width - faceRect.right * scaleX
          : faceRect.left * scaleX;
      final double top = faceRect.top * scaleY;
      final double right = isFrontCamera
          ? size.width - faceRect.left * scaleX
          : faceRect.right * scaleX;
      final double bottom = faceRect.bottom * scaleY;

      final Rect scaledRect = Rect.fromLTRB(left, top, right, bottom);

      // Draw rounded rectangle on face
      canvas.drawRRect(
        RRect.fromRectAndRadius(scaledRect, const Radius.circular(8)),
        paint,
      );

      // Optional: draw corner accents
      _drawCornerAccents(canvas, scaledRect, paint);
    }
  }

  void _drawCornerAccents(Canvas canvas, Rect rect, Paint paint) {
    const double cornerLength = 16.0;
    final Paint cornerPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Top-left
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(0, cornerLength),
      cornerPaint,
    );

    // Top-right
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(-cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(0, cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(0, -cornerLength),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(-cornerLength, 0),
      cornerPaint,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(0, -cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return oldDelegate.faces != faces || oldDelegate.imageSize != imageSize;
  }
}
