import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:face_liveness/core/services/face_detection_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required FaceDetectorService faceDetectorService})
    : _faceDetectorService = faceDetectorService,
      super(const RegistrationState()) {
    on<TakePhotoRequested>(_onTakePhotoRequested);
    on<ChooseImageRequested>(_onChooseImageRequested);
  }
  final FaceDetectorService _faceDetectorService;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onTakePhotoRequested(
    TakePhotoRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    await _processImage(ImageSource.camera, emit);
  }

  Future<void> _processImage(
    ImageSource source,
    Emitter<RegistrationState> emit,
  ) async {
    final image = await _picker.pickImage(source: source);

    if (image == null) return;

    final file = File(image.path);

    final faces = await _faceDetectorService.detectFaces(file);

    debugPrint('Faces Count: ${faces.length}');

    if (faces.isNotEmpty) {
      final face = faces.first;

      debugPrint('Bounding Box: ${face.boundingBox}');
    }

    if (faces.isEmpty) {
      emit(state.copyWith(errorMessage: 'No face detected'));
      return;
    }

    if (faces.length > 1) {
      emit(
        state.copyWith(
          errorMessage:
              'Multiple faces detected. Please select a photo with only one face.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        selectedImage: file,
        errorMessage: null,
        detectedFaces: faces,
      ),
    );
  }

  Future<void> _onChooseImageRequested(
    ChooseImageRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    await _processImage(ImageSource.gallery, emit);
  }
}
