import 'package:face_liveness/core/widgets/image_upload_widget.dart';
import 'package:face_liveness/features/liveness/presentation/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Face')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            return ImageUploadWidget(
              imageFile: state.selectedImage,
              faces: state.detectedFaces,

              onTakePhoto: () {
                context.read<RegistrationBloc>().add(TakePhotoRequested());
              },
              onChooseImage: () {
                context.read<RegistrationBloc>().add(ChooseImageRequested());
              },
            );
          },
        ),
      ),
    );
  }
}
