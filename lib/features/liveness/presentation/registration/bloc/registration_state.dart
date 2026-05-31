part of 'registration_bloc.dart';

@immutable
class RegistrationState {
  const RegistrationState({
    this.selectedImage,
    this.errorMessage,
    this.isLoading = false,
  });

  final File? selectedImage;
  final String? errorMessage;
  final bool isLoading;

  RegistrationState copyWith({
    File? selectedImage,
    String? errorMessage,
    bool? isLoading,
  }) {
    return RegistrationState(
      selectedImage: selectedImage ?? this.selectedImage,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
