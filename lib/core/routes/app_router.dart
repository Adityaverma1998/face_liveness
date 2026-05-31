import 'package:face_liveness/features/liveness/presentation/home/view/screen/home_sceen';
import 'package:face_liveness/features/liveness/presentation/registration/bloc/registration_bloc.dart';
import 'package:face_liveness/features/liveness/presentation/registration/view/screen/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.registerFace:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => RegistrationBloc(),
            child: RegistrationPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route Not Found'))),
        );
    }
  }
}
