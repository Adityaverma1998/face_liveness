part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class TakePhotoRequested extends RegistrationEvent {}

final class ChooseImageRequested extends RegistrationEvent {}

final class DetectFaceRequested extends RegistrationEvent {
  DetectFaceRequested(this.imageFile);

  final File imageFile;
}
