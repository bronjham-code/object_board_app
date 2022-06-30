import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:object_board_app/core/const/general_const.dart';
import 'package:object_board_app/core/router/route_map.dart';
import 'package:object_board_app/core/router/router_redirect.dart';
import 'package:object_board_app/core/theme/app_theme.dart';
import 'package:object_board_app/profile/domain/states/authentication_global_state.dart';
import 'package:object_board_app/splash/domain/states/splash_global_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  Application({super.key});

  late final _routeMap = RouteMap();

  late final _routeRedirect = RouterRedirect(
    splashGlobalState: _splashGlobalState,
    authenticationGlobalState: _authenticationGlobalState,
    routesWithAuthentication: _routeMap.routesWithAuthentication,
  );

  late final _router = GoRouter(
    // initialLocation: RouteMap.buildProfileLocation().toString(),
    debugLogDiagnostics: true,
    routes: _routeMap.buildMap(),
    redirect: _routeRedirect.generalRedirect,
    navigatorBuilder: _routeMap.navigatorBuilder,
  );

  final _splashGlobalState = SplashGlobalState();
  final _authenticationGlobalState = AuthenticationGlobalState();

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => _splashGlobalState),
          Provider(create: (_) => _authenticationGlobalState),
        ],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          title: GeneralConst.applicationTitle,
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
        ),
      );
}
