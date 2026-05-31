part of 'registration_bloc.dart';

@immutable
class RegistrationState {
  const RegistrationState({this.selectedImage});

  final File? selectedImage;

  RegistrationState copyWith({File? selectedImage}) {
    return RegistrationState(
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}
