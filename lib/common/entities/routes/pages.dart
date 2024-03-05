import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiphysio/common/entities/routes/names.dart';
import 'package:hiphysio/pages/global.dart';
import 'package:hiphysio/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:hiphysio/pages/sign_in/sign_in.dart';
import 'package:hiphysio/pages/welcome/bloc/welcome_bloc.dart';
import 'package:hiphysio/pages/welcome/welcome.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const Welcome(),
        bloc: BlocProvider(create: (_) => WelcomeBloc()),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(create: (_) => SignInBloc()),
      ),
      // PageEntity(
      //   route: AppRoutes.REGISTER,
      //   page: const Register(),
      //   bloc: BlocProvider(create: (_) => RegisterBlocs()),
      // ),
      // PageEntity(
      //   route: AppRoutes.APPLICATION,
      //   page: const ApplicationPage(),
      //   bloc: BlocProvider(create: (_) => AppBlocs()),
      // ),
      // PageEntity(
      //   route: AppRoutes.HOME_PAGE,
      //   page: const HomePage(),
      //   bloc: BlocProvider(create: (_) => HomeBlocs()),
      // ),
      // PageEntity(
      //   route: AppRoutes.SETTINGS,
      //   page: const SettingsPage(),
      //   bloc: BlocProvider(create: (_) => SettingsBlocs()),
      // ),
    ];
  }

  // return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      // check for route name match when navigator is triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if (isLoggedIn) {
            // return MaterialPageRoute(
            //     builder: (_) => const ApplicationPage(), settings: settings);
          }
          // return MaterialPageRoute(
          //     builder: (_) => const SignIn(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("Invalid route name : ${settings.name}");

    return MaterialPageRoute(
        builder: (_) => const SignIn(), settings: settings);
  }
}

// unify BlocProvider, routes, and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
