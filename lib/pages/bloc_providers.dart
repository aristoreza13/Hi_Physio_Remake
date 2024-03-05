import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiphysio/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:hiphysio/pages/welcome/bloc/welcome_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        // inject all needed bloc for the app
        BlocProvider(lazy: false, create: (context) => WelcomeBloc()),
        BlocProvider(create: (context) => SignInBloc()),

        // BlocProvider(lazy: false, create: (context) => AppBlocs()),
        // BlocProvider(create: (context) => RegisterBlocs()),
      ];
}
