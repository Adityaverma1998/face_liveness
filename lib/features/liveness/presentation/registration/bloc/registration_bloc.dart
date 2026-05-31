import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<TakePhotoRequested>(_onTakePhotoRequested);
    on<ChooseImageRequested>(_onChooseImageRequested);
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _onTakePhotoRequested(
    TakePhotoRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    emit(state.copyWith(selectedImage: File(image.path)));
  }

  Future<void> _onChooseImageRequested(
    ChooseImageRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    emit(state.copyWith(selectedImage: File(image.path)));
  }
}
