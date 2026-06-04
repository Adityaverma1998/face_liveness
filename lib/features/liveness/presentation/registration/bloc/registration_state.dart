part of 'registration_bloc.dart';

@immutable
class RegistrationState {
  const RegistrationState({
    this.selectedImage,
    this.errorMessage,
    this.isLoading = false,
    this.detectedFaces = const [],
  });

  final File? selectedImage;
  final String? errorMessage;
  final bool isLoading;
  final List<Face> detectedFaces;

  RegistrationState copyWith({
    File? selectedImage,
    String? errorMessage,
    bool? isLoading,
    List<Face>? detectedFaces,
  }) {
    return RegistrationState(
      selectedImage: selectedImage ?? this.selectedImage,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
      detectedFaces: detectedFaces ?? this.detectedFaces,
    );
  }
}
