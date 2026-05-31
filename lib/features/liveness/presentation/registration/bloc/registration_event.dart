part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent {}

final class TakePhotoRequested extends RegistrationEvent {}

final class ChooseImageRequested extends RegistrationEvent {}
