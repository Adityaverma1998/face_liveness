import 'dart:io';
import 'dart:ui' as ui;

import 'package:face_liveness/core/widgets/face_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({
    super.key,
    this.imageFile,
    required this.onTakePhoto,
    required this.onChooseImage,
    this.faces = const [],
  });

  final File? imageFile;
  final VoidCallback onTakePhoto;
  final VoidCallback onChooseImage;
  final List<Face> faces;

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  ui.Image? _decodedImage;
  Size? _imageSize;

  @override
  void didUpdateWidget(covariant ImageUploadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageFile != oldWidget.imageFile && widget.imageFile != null) {
      _loadImageSize(widget.imageFile!);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.imageFile != null) {
      _loadImageSize(widget.imageFile!);
    }
  }

  // Decode image to get real pixel dimensions
  Future<void> _loadImageSize(File file) async {
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    if (mounted) {
      setState(() {
        _decodedImage = image;
        _imageSize = Size(image.width.toDouble(), image.height.toDouble());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("imagefile ${widget.imageFile}");
    print("faces ${widget.faces}");
    return Column(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.imageFile != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      // Base image
                      Image.file(widget.imageFile!, fit: BoxFit.contain),
                      // Face rectangles overlay
                      if (_imageSize != null && widget.faces.isNotEmpty)
                        CustomPaint(
                          painter: FacePainter(
                            faces: widget.faces,
                            imageSize: _imageSize!,
                          ),
                        ),
                      // Face count badge
                      if (widget.faces.isNotEmpty)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${widget.faces.length} face${widget.faces.length > 1 ? 's' : ''} detected',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Icon(
                      Icons.face,
                      size: 120,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: widget.onTakePhoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: widget.onChooseImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Choose Image'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
